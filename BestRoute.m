function Route = BestRoute(CityPermutation,City)
% 根据城市排列表找寻最佳路径
BestMileage = 0;

[column,rank] = size(CityPermutation);
% 分配内存空间
Route = zeros(1,rank);
for i = 1:1:column
    % 对每一种排列
    Mileage = 0;
    % 计算里程
    for j = 1:1:rank-1
        Mileage = Mileage + PointDistance(FindCitybyNumber(City,CityPermutation(i,j)),FindCitybyNumber(City,CityPermutation(i,j+1)));
    end
    % 选最优
    if Mileage > BestMileage
        BestMileage = Mileage;
        Route = CityPermutation(i,:);
    end
end
end

        