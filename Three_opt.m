function [NewRoute]=Three_opt(Route,City)
if length(Route)<7
    NewRoute=Route;
else
    Mileage = 0;
    % �������
    for j = 1:1:length(Route)-1
        Mileage = Mileage + PointDistance(FindCitybyNumber(City,Route(j)),FindCitybyNumber(City,Route(j+1)));
    end
    Route(Route==530100)=[];%ȥ��Դ��
    randindex = randperm(length(Route));
    NewRoute = Route(randindex);%�������
    NewRoute = [530100 NewRoute 530100];%�ӻ�ԭ��
    NewMileage = 0;
    % �������
    for j = 1:1:length(Route)-1
        NewMileage = NewMileage + PointDistance(FindCitybyNumber(City,NewRoute(j)),FindCitybyNumber(City,NewRoute(j+1)));
    end
    if Mileage>NewMileage
        NewRoute = Route;
    end
end

end
