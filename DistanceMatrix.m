Distance = zeros(length(City));
% Distance �����о������
for i = 1:1:length(City)
    for j = 1:1:length(City)
        Distance(i,j)=PointDistance(City(i),City(j));
    end
end