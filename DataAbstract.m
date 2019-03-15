% ���뷢������
% ������Raw_data
[~,~,Raw_data] = xlsread('Data.xls');

% ���ݳ�ȡ
% ��ȡ������Ϣ
% ���кţ��������ڣ��������˴��ID,���κţ�Ҫ�󵽻�����
% ����ΪAbstract_data

Abstract_data = Raw_data(:,[1,9,13,21,24,27]);
Abstract_data(1,:) = [];

Abstract_data(length(Abstract_data),:) = [];
% Abstract_data_martix = cell2mat(Abstract_data);

% ��һ�� ��ϴ�����������ļ�¼
% �������б�� 530100
Abstract_data(cell2mat(Abstract_data(:,4)) == 530100,:) = [];

% �ڶ�����ɾ���������������޵ĳ��������Ϣ

% ���ɻ�����������
% ��һ���ǳ��κ�
% �ڶ����ǻ������
Truck_Number_data = [];
for i = 1:1:length(Abstract_data)
    TruckNumber = cell2mat(Abstract_data(i,5));
    k = find(Truck_Number_data == TruckNumber);
    if k
        Truck_Number_data(k,2) = Truck_Number_data(k,2) +  cell2mat(Abstract_data(i,3));
    else
        Truck_Number_data(end+1,:) = [cell2mat(Abstract_data(i,5)),cell2mat(Abstract_data(i,3))];
    end
end
Truck_Number_data = uint64(Truck_Number_data);

% ��ϴ�ػ������������ 1800Ϊ׼

% ��ȡ���޵ĳ��κ�
TmpTrcukNumber = Truck_Number_data(Truck_Number_data(:,2)>=1800,1);

% �ڴ����ɾ��
for i=1:1:length(TmpTrcukNumber)
    Abstract_data(uint64(cell2mat(Abstract_data(:,5)))==TmpTrcukNumber(i),:)=[];
end

% ��С����ɾ��
Truck_Number_data(Truck_Number_data(:,2)>=1800,:)=[];

% ��ȡ��ͬ����һ��Ϊ��ͬ�ţ��ڶ���Ϊ������������Ŀ�ĵ�ID, ������Ϊ�ջ����ں�2018-06-01�����ڲ�
ContractTable = [cell2mat(Abstract_data(:,1)) cell2mat(Abstract_data(:,3)) cell2mat(Abstract_data(:,4)) datenum(Abstract_data(:,6))-datenum('2018-06-01')];
