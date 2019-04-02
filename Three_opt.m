function [NewRoute]=Three_opt(Route,City)
if length(Route)<7
    NewRoute=Route;
else
    Mileage = 0;
    % 计算里程
    for j = 1:1:length(Route)-1
        Mileage = Mileage + PointDistance(FindCitybyNumber(City,Route(j)),FindCitybyNumber(City,Route(j+1)));
    end
    Route(Route==530100)=[];%去掉源点
    randindex = randperm(length(Route));
    NewRoute = Route(randindex);%随机乱序
    NewRoute = [530100 NewRoute 530100];%加回原点
    NewMileage = 0;
    % 计算里程
    for j = 1:1:length(Route)-1
        NewMileage = NewMileage + PointDistance(FindCitybyNumber(City,NewRoute(j)),FindCitybyNumber(City,NewRoute(j+1)));
    end
    if Mileage>NewMileage
        NewRoute = Route;
    end
end

end
