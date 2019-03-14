% 循环代数 Generation
Generation = 20;
% 群体人口总数
PopulationNumber = 100;
% 承载能力 Capability
Capability = 1800;
% 选择概率 PercentSurvive 淘汰的比例
PercentSurvive = 0.80;
% 精英 Best = Population


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
% Best = Population(1);
% [Best.TruckTable] = Arrangement(Best.Rank,ContractTable,Capability,City);
% Best.Settlement = 0;
% for j = 1:1:length(Best.TruckTable)
%     Best.Settlement = Best.Settlement + Best.TruckTable(j).Mileage;
% end

for g = 1:1:Generation
    %开始循环
    g
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
    
    
    
end
