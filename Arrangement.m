function [TruckTable] = Arrangement(Rank,ContractTable,Capability,City)
% �ڸ����������У����ų���
% ���Ϊ���α�
% ���α�TruckTable ��ţ����أ����, ·�ߣ���ͬ��
TruckTablestruct = struct('Number',0,'Capability',0,'Mileage',0,'Route',[City(1).CityNumber],'Contract',[]);
% ����100���ڴ�ռ�
TruckTable = repmat(TruckTablestruct,[200,1]);
for i = 1:1:length(TruckTable)
    TruckTable(i).Number = i;
    TruckTable(i).Capability = 0;
    TruckTable(i).Mileage = 0;
    TruckTable(i).Route = [City(1).CityNumber];
    TruckTable(i).Contract = [];
end

% j Ϊ�������
j = 1;
for i = 1:1:length(Rank)
    
    % �жϵ�ǰ���Ƿ�����������
    if TruckTable(j).Capability + ContractTable(Rank(i),2) > Capability
        % ���û��
        % ������̡�·�ߣ���ǰ������������
        TruckTable(j).Mileage = TruckTable(j).Mileage + PointDistance(FindCitybyNumber(City,TruckTable(j).Route(end)),City(1));
        TruckTable(j).Route = [TruckTable(j).Route City(1).CityNumber];
        % �³�
        j = j + 1;
    end
    
    % ��Ӻ�ͬ��
    TruckTable(j).Contract(end+1) = ContractTable(i,1);
    % �������
    TruckTable(j).Capability = TruckTable(j).Capability + ContractTable(Rank(i),2);
    % ������
    TruckTable(j).Mileage = TruckTable(j).Mileage + PointDistance(FindCitybyNumber(City,TruckTable(j).Route(end)),FindCitybyNumber(City,ContractTable(i,3)));
    % ���·��
    TruckTable(j).Route = [TruckTable(j).Route ContractTable(i,3)];
    
end
end
