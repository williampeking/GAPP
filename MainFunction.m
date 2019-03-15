

% ѭ������ Generation
Generation = 100;
% Ⱥ���˿�����
PopulationNumber = 200;
% �������� Capability ���������ʱ���鿴
[Capability,~,~,~,~,~] = FourBlock(17.5,2.4,2.9,0.455,0.243,0.57);
% ѡ����� PercentSurvive ��̭�ı���
PercentSurvive = 0.80;
% ���������� PercentVariation_TwoPoint
PercentVariation_TwoPoint = 0.1;
% ��·���Ż����� PercentVariation_Route
PercentVariation_Route = 0.1;
% ��Ӣ Best = Population

if ~exist('City','var')
    City_data;
end

if ~exist('ContractTable','var')
    DataAbstract;
end


% ������Ⱥ�ṹ��
PopulationStruct = struct('Number',0,'Rank',[],'Settlement',0.0,'TruckTable',[]);
% Number ������
% Rank ����˳��
% Settlement ����λ�������
% TruckTable ��������¼������ţ��������������, ·�ߣ� ��ͬ



% ����ռ�
Population = repmat(PopulationStruct,[PopulationNumber,1]);

% ��ʼ����Ⱥ
for i = 1:1:PopulationNumber
    Rank = randperm(length(ContractTable));
    Population(i).Rank = Rank;
    Population(i).Number = i;
    Population(i).Settlement = 0;
end
% ��Ӣ��ʼ��
Best = repmat(PopulationStruct,[1,1]);
Best.Number = Population(1).Number;
Best.Rank = Population(1).Rank;
[Best.TruckTable] = Arrangement(Best.Rank,ContractTable,Capability,City);
Best.Settlement = 0;
for j = 1:1:length(Best.TruckTable)
    Best.Settlement = Best.Settlement + Best.TruckTable(j).Mileage;
end

for g = 1:1:Generation
    % ��ʼѭ��
    fprintf("��ǰΪ��%d�����ܼ�%d������ɶ�%.2f%%\n",g,Generation,g/Generation*100);
    % ����
    for i = 1:1:PopulationNumber
        [Population(i).TruckTable] = Arrangement(Population(i).Rank,ContractTable,Capability,City);
        Population(i).Settlement = 0;
        for j = 1:1:length(Population(i).TruckTable)
            Population(i).Settlement = Population(i).Settlement + Population(i).TruckTable(j).Mileage;
        end
    end
    
    % ѡ��
    % ����
    [~,index] = sort([Population.Settlement]);
    Population = Population(index);
    
    % ����
    % ��̭ĩβ�����������Ӵ�
    TheLine = round(PopulationNumber*(1-PercentSurvive));
    for i = TheLine+1:2:PopulationNumber
        if i + 1 <= PopulationNumber
            [Population(i).Rank, Population(i+1).Rank ] = Mating(Population(randperm(TheLine,1)).Rank,Population(randperm(TheLine,1)).Rank);
            [Population(i).TruckTable] = Arrangement(Population(i).Rank,ContractTable,Capability,City);
            Population(i).Settlement = 0;
            Population(i+1).Settlement = 0;
            for j = 1:1:length(Population(i).TruckTable)
                Population(i).Settlement = Population(i).Settlement + Population(i).TruckTable(j).Mileage;
            end
            for j = 1:1:length(Population(i+1).TruckTable)
                Population(i+1).Settlement = Population(i+1).Settlement + Population(i+1).TruckTable(j).Mileage;
            end
        end
    end
    

    % ����
    
    % �������
    % ������ɱ������У����ݱ������
    VariationIndex = randperm(PopulationNumber,PopulationNumber * PercentVariation_TwoPoint);
    for i = 1:1:length(VariationIndex)
        % ����������������
        VariationPoint = randperm(length(ContractTable),2);
        % ������ʱ�ռ���н���
         Temp = Population(VariationIndex(i)).Rank(VariationPoint(1));
        Population(VariationIndex(i)).Rank(VariationPoint(1)) = Population(VariationIndex(i)).Rank(VariationPoint(2)); 
        Population(VariationIndex(i)).Rank(VariationPoint(2)) = Temp;
        
        %����
        [Population(VariationIndex(i)).TruckTable] = Arrangement(Population(VariationIndex(i)).Rank,ContractTable,Capability,City);
        Population(VariationIndex(i)).Settlement = 0;
        for j = 1:1:length(Population(VariationIndex(i)).TruckTable)
            Population(VariationIndex(i)).Settlement = Population(VariationIndex(i)).Settlement + Population(VariationIndex(i)).TruckTable(j).Mileage;
        end
    end
    % ��·���Ż�
    % �Ե����г�·�߽����Ż�
    % ������ɱ������У����ݱ������
    VariationIndex = randperm(PopulationNumber,PopulationNumber * PercentVariation_Route);
    for i = 1:1:length(VariationIndex)
                
        for j = 1:1:length(Population(VariationIndex(i)).TruckTable)
            % �ж�ÿ������·���Ƿ����Ż��ռ䣬
            if length(Population(VariationIndex(i)).TruckTable(j).Route)<=4
                continue;
            else
                % ͳ�Ƴ���
                CityTmp = unique(Population(VariationIndex(i)).TruckTable(j).Route);
                % ȥ����������
                CityTmp(CityTmp == City(1).CityNumber) = [];
                % ȫ������
                CityPermutation = perms(CityTmp);
                % ����ͷβ
                CityPermutation = [ones(length(CityPermutation),1)*(City(1).CityNumber) CityPermutation ones(length(CityPermutation),1)*(City(1).CityNumber)];
                
                Contract = [];
                Route = BestRoute(CityPermutation,City);
                
                % ������ʱ���к�ͬ��
                CityContractTable = zeros(length(Population(VariationIndex(i)).TruckTable(j).Contract),2);
                for k = 1:1:length(Population(VariationIndex(i)).TruckTable(j).Contract)
                    r = find(ContractTable(:,1) == Population(VariationIndex(i)).TruckTable(j).Contract(k));
                    CityContractTable(k,1) = ContractTable(r,3);
                    CityContractTable(k,2) = ContractTable(r,1);
                end
                % ������ʱ���к��������ɺ�ͬ����
                for c = 1:1:length(Route)
                    C_Index = find(CityContractTable == Route(c));
                    Contract = [ Contract CityContractTable(C_Index,2)'];
                end
                % ����·�ߺͺ�ͬ��
                
                
                
                Population(VariationIndex(i)).TruckTable(j).Contract = Contract;
                Population(VariationIndex(i)).TruckTable(j).Route = Route;
                 
            end
            
        
        end
        
        % ������Rank
        Rank = [];
        for j = 1:1:length(Population(VariationIndex(i)).TruckTable)
            Rank = [Rank Population(VariationIndex(i)).TruckTable(j).Contract];
        end
        % ��ʱRank����ΪContractTable��һ�����ݣ�����ӦԴ���ݵ���ţ���Ҫת��
        RealRank = zeros(1,length(Rank));
        for j = 1:1:length(Rank)
            RealRank(j) = find(ContractTable(:,1) == Rank(j));
        end
        Population(VariationIndex(i)).Rank = RealRank;
        
        %����
        [Population(VariationIndex(i)).TruckTable] = Arrangement(Population(VariationIndex(i)).Rank,ContractTable,Capability,City);
        Population(VariationIndex(i)).Settlement = 0;
        for j = 1:1:length(Population(VariationIndex(i)).TruckTable)
            Population(VariationIndex(i)).Settlement = Population(VariationIndex(i)).Settlement + Population(VariationIndex(i)).TruckTable(j).Mileage;
        end
    end
    
    % ��Ӣ����
    [~,index] = sort([Population.Settlement]);
    Population = Population(index);
    
    if Population(1).Settlement < Best.Settlement
        Best.Number = Population(1).Number;
        Best.Rank = Population(1).Rank;
        Best.TruckTable = Population(1).TruckTable;
        Best.Settlement = Population(1).Settlement;
    else
        Population(PopulationNumber).Rank = Best.Rank;
        Population(PopulationNumber).TruckTable = Best.TruckTable;
        Population(PopulationNumber).Settlement = Best.Settlement;
    end
end
PrimaryTruckMileageSettlement
fprintf("�Ż�ǰ���Ϊ:%f\n",PrimarySettelment);
fprintf("���ս�����Ϊ:%f,����������Best\n",Best.Settlement);

