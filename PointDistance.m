function distance = PointDistance(City_A, City_B)
% ���ݾ�γ�������
% ���� longitude
% γ�� latitude

% ����ƽ���뾶 R = 6371.004 km
R = 6371.004;

% �Ƕ�ת����
A_longitude = City_A.Longitude/180*pi;
A_latitude = City_A.Latitude/180*pi;

B_longitude = City_B.Longitude/180*pi;
B_latitude = City_B.Latitude/180*pi;


distance =acos((sin(A_latitude)*sin(B_latitude)) + (cos(A_latitude)*cos(B_latitude)*cos(A_longitude-B_longitude)))*R;

end