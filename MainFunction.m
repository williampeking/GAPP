

% 循环代数 Generation
Generation = 100;
% 群体人口总数
PopulationNumber = 200;
% 承载能力 Capability 其余参数暂时不查看
[Capability, x,y,number_tier,tier,sign] = FourBlock(17.5,2.4,2.9,0.455,0.243,0.57);
% 选择概率 PercentSurvive 淘汰的比例
PercentSurvive = 0.80;
% 两点变异概率 PercentVariation_TwoPoint
PercentVariation_TwoPoint = 0.1;
% 子路径优化概率 PercentVariation_Route
PercentVariation_Route = 0.1;
% 精英 Best = Population

if ~exist('City','var')
    City_data;
end

if ~exist('ContractTable','var')
    DataAbstract;
end


% 定义种群结构体
PopulationStruct = struct('Number',0,'Rank',[],'Settlement',0.0,'TruckTable',[]);
% Number 个体编号
% Rank 货物顺序
% Settlement 结算位，总里程
% TruckTable 卡车表，记录卡车编号，货运数量，里程, 路线， 合同



% 分配空间
Population = repmat(PopulationStruct,[PopulationNumber,1]);

% 初始化种群
for i = 1:1:PopulationNumber
    Rank = randperm(length(ContractTable));
    Population(i).Rank = Rank;
    Population(i).Number = i;
    Population(i).Settlement = 0;
end
% 精英初始化
Best = repmat(PopulationStruct,[1,1]);
Best.Number = Population(1).Number;
Best.Rank = Population(1).Rank;
[Best.TruckTable] = Arrangement(Best.Rank,ContractTable,Capability,City);
Best.Settlement = 0;
for j = 1:1:length(Best.TruckTable)
    Best.Settlement = Best.Settlement + Best.TruckTable(j).Mileage;
end

for g = 1:1:Generation
    % 开始循环
    fprintf("当前为第%d代，总计%d代，完成度%.2f%%\n",g,Generation,g/Generation*100);
    % 评估
    for i = 1:1:PopulationNumber
        [Population(i).TruckTable] = Arrangement(Population(i).Rank,ContractTable,Capability,City);
        Population(i).Settlement = 0;
        for j = 1:1:length(Population(i).TruckTable)
            Population(i).Settlement = Population(i).Settlement + Population(i).TruckTable(j).Mileage;
        end
    end
    
    % 选择
    % 排序
    [~,index] = sort([Population.Settlement]);
    Population = Population(index);
    
    % 交叉
    % 淘汰末尾并交叉生成子代
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
    

    % 变异
    
    % 两点变异
    % 随机生成变异序列，根据变异概率
    VariationIndex = randperm(PopulationNumber,PopulationNumber * PercentVariation_TwoPoint);
    for i = 1:1:length(VariationIndex)
        % 生成两个随机变异点
        VariationPoint = randperm(length(ContractTable),2);
        % 利用临时空间进行交换
         Temp = Population(VariationIndex(i)).Rank(VariationPoint(1));
        Population(VariationIndex(i)).Rank(VariationPoint(1)) = Population(VariationIndex(i)).Rank(VariationPoint(2)); 
        Population(VariationIndex(i)).Rank(VariationPoint(2)) = Temp;
        
        %结算
        [Population(VariationIndex(i)).TruckTable] = Arrangement(Population(VariationIndex(i)).Rank,ContractTable,Capability,City);
        Population(VariationIndex(i)).Settlement = 0;
        for j = 1:1:length(Population(VariationIndex(i)).TruckTable)
            Population(VariationIndex(i)).Settlement = Population(VariationIndex(i)).Settlement + Population(VariationIndex(i)).TruckTable(j).Mileage;
        end
    end
    % 子路径优化
    % 对单车行车路线进行优化
    % 随机生成变异序列，根据变异概率
    VariationIndex = randperm(PopulationNumber,PopulationNumber * PercentVariation_Route);
    for i = 1:1:length(VariationIndex)
                
        for j = 1:1:length(Population(VariationIndex(i)).TruckTable)
            % 判断每辆车的路线是否有优化空间，
            if length(Population(VariationIndex(i)).TruckTable(j).Route)<=4
                continue;
            else
                % 统计城市
                CityTmp = unique(Population(VariationIndex(i)).TruckTable(j).Route);
                % 去除配送中心
                CityTmp(CityTmp == City(1).CityNumber) = [];
                % 全部排列
                CityPermutation = perms(CityTmp);
                % 加上头尾
                CityPermutation = [ones(length(CityPermutation),1)*(City(1).CityNumber) CityPermutation ones(length(CityPermutation),1)*(City(1).CityNumber)];
                
                Contract = [];
                Route = BestRoute(CityPermutation,City);
                
                % 构建临时城市合同表
                CityContractTable = zeros(length(Population(VariationIndex(i)).TruckTable(j).Contract),2);
                for k = 1:1:length(Population(VariationIndex(i)).TruckTable(j).Contract)
                    r = find(ContractTable(:,1) == Population(VariationIndex(i)).TruckTable(j).Contract(k));
                    CityContractTable(k,1) = ContractTable(r,3);
                    CityContractTable(k,2) = ContractTable(r,1);
                end
                % 根据临时城市合作表，生成合同序列
                for c = 1:1:length(Route)
                    C_Index = find(CityContractTable == Route(c));
                    Contract = [ Contract CityContractTable(C_Index,2)'];
                end
                % 更新路线和合同单
                
                
                
                Population(VariationIndex(i)).TruckTable(j).Contract = Contract;
                Population(VariationIndex(i)).TruckTable(j).Route = Route;
                 
            end
            
        
        end
        
        % 生成新Rank
        Rank = [];
        for j = 1:1:length(Population(VariationIndex(i)).TruckTable)
            Rank = [Rank Population(VariationIndex(i)).TruckTable(j).Contract];
        end
        % 此时Rank内容为ContractTable第一列内容，即对应源数据的序号，需要转换
        RealRank = zeros(1,length(Rank));
        for j = 1:1:length(Rank)
            RealRank(j) = find(ContractTable(:,1) == Rank(j));
        end
        Population(VariationIndex(i)).Rank = RealRank;
        
        %结算
        [Population(VariationIndex(i)).TruckTable] = Arrangement(Population(VariationIndex(i)).Rank,ContractTable,Capability,City);
        Population(VariationIndex(i)).Settlement = 0;
        for j = 1:1:length(Population(VariationIndex(i)).TruckTable)
            Population(VariationIndex(i)).Settlement = Population(VariationIndex(i)).Settlement + Population(VariationIndex(i)).TruckTable(j).Mileage;
        end
    end
    
    % 精英保护
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
fprintf("优化前里程为:%f\n",PrimarySettelment);
fprintf("最终结果里程为:%f,具体参数详见Best\n",Best.Settlement);

