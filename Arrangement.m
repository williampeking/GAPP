function [TruckTable,TruckContract] = Arrangement(Rank,ContractTable,~,City)
% �ڸ����������У����ų���
% ���Ϊ���α�
% ���α�TruckTable��һ��Ϊ��ţ��ڶ���Ϊ���أ�������Ϊ���
% ���κ�ͬ��TruckContract ����Ϊ��������ĺ�ͬ��
Capablility = 1800;
% j Ϊ�������
j = 1;
TruckTable = [];
TruckTable(j,1) = j;
TruckTable(j,2) = 0;
TruckTable(j,3) = 0;

TruckContract{j,1} = j;
TruckContract{j,2} = {};

TmpCity = City(1);

for i = 1:1:length(Rank)
    
    % �жϵ�ǰ���Ƿ�����������
    if TruckTable(j,2) + ContractTable(Rank(i),2) <= Capablility
        
        % �����
        
        % ��Ӻ�ͬ��
        TruckContract{j,2}= [TruckContract{j,2} ContractTable(i,1)];
        % �������
        TruckTable(j,2) = TruckTable(j,2) + ContractTable(Rank(i),2);
        % ������
        TruckTable(j,3) = TruckTable(j,3) + PointDistance(TmpCity,FindCitybyNumber(City,ContractTable(i,3)));
        % ���³���
        TmpCity = FindCitybyNumber(City,ContractTable(i,3));
    else
        % ������̣���ǰ������������
        TruckTable(j,3) = TruckTable(j,3) + PointDistance(TmpCity,City(1));
        TmpCity = City(1);
        
        % �³�
        j = j + 1;
        TruckContract{j,1} = j;
        
        TruckTable(j,1) = j;
        TruckTable(j,2) = 0;
        TruckTable(j,3) = 0;
        
        % ��Ӻ�ͬ��
        TruckContract{j,2}= [TruckContract{j,2} ContractTable(i,1)];
        % �������
        TruckTable(j,2) = TruckTable(j,2) + ContractTable(Rank(i),2);
        % ������
        TruckTable(j,3) = TruckTable(j,3) + PointDistance(TmpCity,FindCitybyNumber(City,ContractTable(i,3)));
        % ���³���
        TmpCity = FindCitybyNumber(City,ContractTable(i,3));

    end
end
end