% 导入发货数据
% 保存在Raw_data
[~,~,Raw_data] = xlsread('Data.xls');

% 数据抽取
% 抽取有用信息
% 序列号，发布日期，数量，运达地ID,车次号，要求到货日期
% 保存为Abstract_data

Abstract_data = Raw_data(:,[1,9,13,21,24,27]);
Abstract_data(1,:) = [];

Abstract_data(length(Abstract_data),:) = [];
% Abstract_data_martix = cell2mat(Abstract_data);

% 第一步 清洗掉发往昆明的记录
% 昆明城市编号 530100
Abstract_data(cell2mat(Abstract_data(:,4)) == 530100,:) = [];

% 第二步，删除货运量超过超限的车次相关信息

% 生成货车数量数据
% 第一列是车次号
% 第二列是货物件数
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

% 清洗载货量过多的数据 1800为准

% 提取超限的车次号
TmpTrcukNumber = Truck_Number_data(Truck_Number_data(:,2)>=1800,1);

% 在大表中删除
for i=1:1:length(TmpTrcukNumber)
    Abstract_data(uint64(cell2mat(Abstract_data(:,5)))==TmpTrcukNumber(i),:)=[];
end

% 在小表中删除
Truck_Number_data(Truck_Number_data(:,2)>=1800,:)=[];

% 抽取合同表，第一列为合同号，第二列为数量，第三列目的地ID, 第四列为收货日期和2018-06-01的日期差
ContractTable = [cell2mat(Abstract_data(:,1)) cell2mat(Abstract_data(:,3)) cell2mat(Abstract_data(:,4)) datenum(Abstract_data(:,6))-datenum('2018-06-01')];


