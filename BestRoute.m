function Route = BestRoute(CityPermutation,City)
% ���ݳ������б���Ѱ���·��
BestMileage = 0;

[column,rank] = size(CityPermutation);
% �����ڴ�ռ�
Route = zeros(1,rank);
for i = 1:1:column
    % ��ÿһ������
    Mileage = 0;
    % �������
    for j = 1:1:rank-1
        Mileage = Mileage + PointDistance(FindCitybyNumber(City,CityPermutation(i,j)),FindCitybyNumber(City,CityPermutation(i,j+1)));
    end
    % ѡ����
    if Mileage > BestMileage
        BestMileage = Mileage;
        Route = CityPermutation(i,:);
    end
end
end

        