function city = FindCitybyNumber(City,citynumber)
% 根据城市编号查找城市信息
for i = 1:1:length(City)
    if City(i).CityNumber == citynumber
        city = City(i);
    end
end

end