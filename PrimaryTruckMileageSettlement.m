% ���㾭�����
PrimaryTruckMileage = [];
for i = 1:1:length(Abstract_data)
    k = find(PrimaryTruckMileage == cell2mat(Abstract_data(i,5)));
   if k % ����ҵ�
       % ����1����ǰ����
       c1 = FindCitybyNumber(City,PrimaryTruckMileage(k,2));
       % ����2��Ŀ�ĳ���
       c2 = FindCitybyNumber(City,cell2mat(Abstract_data(i,4)));
       % �����
       dist = PointDistance(c1,c2);
       % �������
       PrimaryTruckMileage(k,3) = PrimaryTruckMileage(k,3) + dist;
       % ���³���
       PrimaryTruckMileage(k,2) = cell2mat(Abstract_data(i,4));
   else
       % ��ʼ���³���
       PrimaryTruckMileage(end+1,:) = [cell2mat(Abstract_data(i,5)),City(1).CityNumber,0];
       
       k = find(PrimaryTruckMileage == cell2mat(Abstract_data(i,5)));
       
       % ����1����ǰ����
       c1 = FindCitybyNumber(City,PrimaryTruckMileage(k,2));
       % ����2��Ŀ�ĳ���
       c2 = FindCitybyNumber(City,cell2mat(Abstract_data(i,4)));
       % �����
       dist = PointDistance(c1,c2);
       % �������
       PrimaryTruckMileage(k,3) = PrimaryTruckMileage(k,3) + dist;
       % ���³���
       PrimaryTruckMileage(k,2) = cell2mat(Abstract_data(i,4));
   end
end

% ���г��ص�ԭ��
for i = 1:1:length(PrimaryTruckMileage)
    c1 = FindCitybyNumber(City,PrimaryTruckMileage(k,2));
    c2 = City(1);
    PrimaryTruckMileage(i,3) = PrimaryTruckMileage(i,3) + PointDistance(c1,c2);
end

% ���������
PrimarySettelment = sum(PrimaryTruckMileage(:,3));
NewSettlement = sum(TruckTable(:,3));

