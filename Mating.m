function [New_Rank1,New_Rank2] = Mating(Rank1,Rank2)

% Rank1,Rank2 为原生染色体
% New_Rank1,New_Rank2 为子个体



% 生成两个交叉点
%CrossPoint1，CrossPoint2 为交叉点

% TempIndex 为不重复的乱序
TempIndex = randperm(length(Rank1)-1);
%要求交叉点一小于交叉点二
if TempIndex(1) < TempIndex(2)
    CrossPoint1 = TempIndex(1);
    CrossPoint2 = TempIndex(2);
else
    CrossPoint2 = TempIndex(1);
    CrossPoint1 = TempIndex(2);
end

% 为子个体分配内存
New_Rank1 = zeros(1,length(Rank1));
New_Rank2 = zeros(1,length(Rank2));

% 复制从第一个交叉点到第二个交叉点的基因到子个体
New_Rank1(1:(CrossPoint2-CrossPoint1)) = Rank1((CrossPoint1+1):CrossPoint2);
New_Rank2(1:(CrossPoint2-CrossPoint1)) = Rank2((CrossPoint1+1):CrossPoint2);

% 移动从染色体第一个交叉点到第二个交叉点的所有基因到染色体末尾

TmpRank1 = [Rank1((CrossPoint2+1):length(Rank1)) Rank1(1:CrossPoint2)];
TmpRank2 = [Rank2((CrossPoint2+1):length(Rank2)) Rank2(1:CrossPoint2)];

% 遍历Rank2中所有基因，判断子个体New_Rank1中是否存在该基因，如果不存在，则依次添加到子代末尾，Rank1同理
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