function [New_Rank1,New_Rank2] = Mating(Rank1,Rank2)

% Rank1,Rank2 Ϊԭ��Ⱦɫ��
% New_Rank1,New_Rank2 Ϊ�Ӹ���



% �������������
%CrossPoint1��CrossPoint2 Ϊ�����

% TempIndex Ϊ���ظ�������
TempIndex = randperm(length(Rank1)-1);
%Ҫ�󽻲��һС�ڽ�����
if TempIndex(1) < TempIndex(2)
    CrossPoint1 = TempIndex(1);
    CrossPoint2 = TempIndex(2);
else
    CrossPoint2 = TempIndex(1);
    CrossPoint1 = TempIndex(2);
end

% Ϊ�Ӹ�������ڴ�
New_Rank1 = zeros(1,length(Rank1));
New_Rank2 = zeros(1,length(Rank2));

% ���ƴӵ�һ������㵽�ڶ��������Ļ����Ӹ���
New_Rank1(1:(CrossPoint2-CrossPoint1)) = Rank1((CrossPoint1+1):CrossPoint2);
New_Rank2(1:(CrossPoint2-CrossPoint1)) = Rank2((CrossPoint1+1):CrossPoint2);

% �ƶ���Ⱦɫ���һ������㵽�ڶ������������л���Ⱦɫ��ĩβ

TmpRank1 = [Rank1((CrossPoint2+1):length(Rank1)) Rank1(1:CrossPoint2)];
TmpRank2 = [Rank2((CrossPoint2+1):length(Rank2)) Rank2(1:CrossPoint2)];

% ����Rank2�����л����ж��Ӹ���New_Rank1���Ƿ���ڸû�����������ڣ���������ӵ��Ӵ�ĩβ��Rank1ͬ��
j = (CrossPoint2-CrossPoint1) + 1;
for i = 1:1:length(TmpRank2)
    k = find(New_Rank1 == TmpRank2(i));
    if k
        continue;
    else
        New_Rank1(j) = TmpRank2(i);
        j = j + 1;
    end
end

j = (CrossPoint2-CrossPoint1) + 1;
for i = 1:1:length(TmpRank1)
    k = find(New_Rank2 == TmpRank1(i));
    if k
        continue;
    else
        New_Rank2(j) = TmpRank1(i);
        j = j + 1;
    end
end

end