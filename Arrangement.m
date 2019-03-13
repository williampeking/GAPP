function [TruckTable,TruckContract] = Arrangement(Rank,ContractTable,~,City)
% 在给定货物序列，安排车次
% 输出为车次表
% 车次表TruckTable第一列为序号，第二列为载重，第三列为里程
% 车次合同表TruckContract 内容为汽车运输的合同号
Capablility = 1800;
% j 为车次序号
j = 1;
TruckTable = [];
TruckTable(j,1) = j;
TruckTable(j,2) = 0;
TruckTable(j,3) = 0;

TruckContract{j,1} = j;
TruckContract{j,2} = {};

TmpCity = City(1);

for i = 1:1:length(Rank)
    
    % 判断当前车是否有载重能力
    if TruckTable(j,2) + ContractTable(Rank(i),2) <= Capablility
        
        % 如果有
        
        % 添加合同号
        TruckContract{j,2}= [TruckContract{j,2} ContractTable(i,1)];
        % 添加载重
        TruckTable(j,2) = TruckTable(j,2) + ContractTable(Rank(i),2);
        % 添加里程
        TruckTable(j,3) = TruckTable(j,3) + PointDistance(TmpCity,FindCitybyNumber(City,ContractTable(i,3)));
        % 更新城市
        TmpCity = FindCitybyNumber(City,ContractTable(i,3));
    else
        % 更新里程，当前车回配送中心
        TruckTable(j,3) = TruckTable(j,3) + PointDistance(TmpCity,City(1));
        TmpCity = City(1);
        
        % 新车
        j = j + 1;
        TruckContract{j,1} = j;
        
        TruckTable(j,1) = j;
        TruckTable(j,2) = 0;
        TruckTable(j,3) = 0;
        
        % 添加合同号
        TruckContract{j,2}= [TruckContract{j,2} ContractTable(i,1)];
        % 添加载重
        TruckTable(j,2) = TruckTable(j,2) + ContractTable(Rank(i),2);
        % 添加里程
        TruckTable(j,3) = TruckTable(j,3) + PointDistance(TmpCity,FindCitybyNumber(City,ContractTable(i,3)));
        % 更新城市
        TmpCity = FindCitybyNumber(City,ContractTable(i,3));

    end
end
end