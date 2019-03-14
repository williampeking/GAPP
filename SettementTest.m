% ѭ������ Generation
Generation = 20;
% Ⱥ���˿�����
PopulationNumber = 100;
% �������� Capability
Capability = 1800;
% ѡ����� PercentSurvive ��̭�ı���
PercentSurvive = 0.80;
% ��Ӣ Best = Population


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
% Best = Population(1);
% [Best.TruckTable] = Arrangement(Best.Rank,ContractTable,Capability,City);
% Best.Settlement = 0;
% for j = 1:1:length(Best.TruckTable)
%     Best.Settlement = Best.Settlement + Best.TruckTable(j).Mileage;
% end

for g = 1:1:Generation
    %��ʼѭ��
    g
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
    
    
    
end
