function city = FindCitybyNumber(City,citynumber)
% ���ݳ��б�Ų��ҳ�����Ϣ
for i = 1:1:length(City)
    if City(i).CityNumber == citynumber
        city = City(i);
    end
end

end