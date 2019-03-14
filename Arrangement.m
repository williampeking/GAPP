function [TruckTable] = Arrangement(Rank,ContractTable,Capability,City)
% 在给定货物序列，安排车次
% 输出为车次表
% 车次表TruckTable 序号，载重，里程, 路线，合同号
TruckTablestruct = struct('Number',0,'Capability',0,'Mileage',0,'Route',[City(1).CityNumber],'Contract',[]);
% 分配100个内存空间
TruckTable = repmat(TruckTablestruct,[200,1]);
for i = 1:1:length(TruckTable)
    TruckTable(i).Number = i;
    TruckTable(i).Capability = 0;
    TruckTable(i).Mileage = 0;
    TruckTable(i).Route = [City(1).CityNumber];
    TruckTable(i).Contract = [];
end

% j 为车次序号
j = 1;
for i = 1:1:length(Rank)
    
    % 判断当前车是否有载重能力
    if TruckTable(j).Capability + ContractTable(Rank(i),2) > Capability
        % 如果没有
        % 更新里程、路线，当前车回配送中心
        TruckTable(j).Mileage = TruckTable(j).Mileage + PointDistance(FindCitybyNumber(City,TruckTable(j).Route(end)),City(1));
        TruckTable(j).Route = [TruckTable(j).Route City(1).CityNumber];
        % 新车
        j = j + 1;
    end
    
    % 添加合同号
    TruckTable(j).Contract(end+1) = ContractTable(i,1);
    % 添加载重
    TruckTable(j).Capability = TruckTable(j).Capability + ContractTable(Rank(i),2);
    % 添加里程
    TruckTable(j).Mileage = TruckTable(j).Mileage + PointDistance(FindCitybyNumber(City,TruckTable(j).Route(end)),FindCitybyNumber(City,ContractTable(i,3)));
    % 添加路线
    if TruckTable(j).Route(end) ~= ContractTable(i,3)
        TruckTable(j).Route = [TruckTable(j).Route ContractTable(i,3)];
    end
    
end

% 最后的车，要回城
TruckTable(j).Mileage = TruckTable(j).Mileage + PointDistance(FindCitybyNumber(City,TruckTable(j).Route(end)),City(1));
TruckTable(j).Route = [TruckTable(j).Route City(1).CityNumber];
end
