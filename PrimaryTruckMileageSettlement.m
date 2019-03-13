% 计算经典里程
PrimaryTruckMileage = [];
for i = 1:1:length(Abstract_data)
    k = find(PrimaryTruckMileage == cell2mat(Abstract_data(i,5)));
   if k % 如果找到
       % 城市1，当前城市
       c1 = FindCitybyNumber(City,PrimaryTruckMileage(k,2));
       % 城市2，目的城市
       c2 = FindCitybyNumber(City,cell2mat(Abstract_data(i,4)));
       % 算距离
       dist = PointDistance(c1,c2);
       % 更新里程
       PrimaryTruckMileage(k,3) = PrimaryTruckMileage(k,3) + dist;
       % 更新城市
       PrimaryTruckMileage(k,2) = cell2mat(Abstract_data(i,4));
   else
       % 初始化新车次
       PrimaryTruckMileage(end+1,:) = [cell2mat(Abstract_data(i,5)),City(1).CityNumber,0];
       
       k = find(PrimaryTruckMileage == cell2mat(Abstract_data(i,5)));
       
       % 城市1，当前城市
       c1 = FindCitybyNumber(City,PrimaryTruckMileage(k,2));
       % 城市2，目的城市
       c2 = FindCitybyNumber(City,cell2mat(Abstract_data(i,4)));
       % 算距离
       dist = PointDistance(c1,c2);
       % 更新里程
       PrimaryTruckMileage(k,3) = PrimaryTruckMileage(k,3) + dist;
       % 更新城市
       PrimaryTruckMileage(k,2) = cell2mat(Abstract_data(i,4));
   end
end

% 所有车回到原点
for i = 1:1:length(PrimaryTruckMileage)
    c1 = FindCitybyNumber(City,PrimaryTruckMileage(k,2));
    c2 = City(1);
    PrimaryTruckMileage(i,3) = PrimaryTruckMileage(i,3) + PointDistance(c1,c2);
end

% 结算总里程
PrimarySettelment = sum(PrimaryTruckMileage(:,3));
NewSettlement = sum(TruckTable(:,3));

