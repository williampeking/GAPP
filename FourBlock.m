function [number,x,y,number_tier,tier,sign]=FourBlock(truck_length,truck_width,truck_height,box_length,box_width,box_height)
% truck_length ��������
% truck_width ��������
% truck_height �����߶�
% box_length ���ӳ���
% box_width ���ӿ���
% box_height ���Ӹ߶�
% ��λ����

tier_length = floor(truck_length/box_length);
tier_width = floor(truck_length/box_width);
tier_height= floor(truck_length/box_height);
%�������в���

x = zeros(1,4);
y = zeros(1,4);
number = 0;
number_tier = 0;
tier = 0;
sign = 0;%0Ϊ��ʼֵ��1λ���ȷ���2Ϊ���ȷ���3Ϊ�߶ȷ���

%�Գ���Ϊ����
%��Ϊx����Ϊy
x_1_max = floor(truck_width/box_width);
x_2_max = floor(truck_height/box_width);
y_4_max = floor(truck_height/box_height);
% x_1_max��Ϊ�������ֵ


for x1 = 0:1:x_1_max% ѭ������
   y1 = floor((truck_width - x1*box_width)/box_height);
   for x2 = 0:1:x_2_max
       y2 = floor((truck_height-x2*box_width)/box_height);
       for y4 =0:1:y_4_max
           x4 = floor((truck_height-y4*box_height)/box_width);
           if x2*box_width<=y4*box_height% ��������������ۣ�ע�⣬�����ǰ����ȷֲ㣬�����������������
               x3 = floor((truck_width-x1*box_width)/box_width);
               y3 = floor((truck_width-x3*box_width)/box_height);
           else
               x3 = round(y1*box_height/box_width);
               y3 = floor((truck_width-x3*box_width)/box_height);
               %�������룬���ǵ���������
           end
           %����ж�
           number_tmp = (x1*y4+x2*y1+x3*y2+x4*y3)*tier_length;
           if number<number_tmp
               number = number_tmp;
               sign = 1;
               number_tier = (x1*y4+x2*y1+x3*y2+x4*y3);
               tier = tier_length;
               x = [x1,x2,x3,x4];
               y = [y1,y2,y3,y4];
           end
       end
   end
end


%�Կ���Ϊ����
%��Ϊx����Ϊy
x_1_max = floor(truck_width/box_length);
x_2_max = floor(truck_height/box_length);
y_4_max = floor(truck_height/box_height);

for x1 = 0:1:x_1_max
   y1 = floor((truck_width - x1*box_length)/box_height);
   for x2 = 0:1:x_2_max
       y2 = floor((truck_height-x2*box_length)/box_height);
       for y4 =0:1:y_4_max
           x4 = floor((truck_height-y4*box_height)/box_length);
           if x2*box_length<=y4*box_height
               x3 = floor((truck_width-x1*box_length)/box_length);
               y3 = floor((truck_width-x3*box_length)/box_height);
           else
               x3 = round(y1*box_height/box_length);
               y3 = floor((truck_width-x3*box_length)/box_height);
               %�������룬���ǵ���������
           end
           %����ж�
           number_tmp = (x1*y4+x2*y1+x3*y2+x4*y3)*tier_width;
           if number<number_tmp
               number = number_tmp;
               sign = 2;
               number_tier = (x1*y4+x2*y1+x3*y2+x4*y3);
               tier = tier_width;
               x = [x1,x2,x3,x4];
               y = [y1,y2,y3,y4];
           end
       end
   end
end


%�Ը߶�Ϊ����
%��Ϊx����Ϊy
x_1_max = floor(truck_width/box_width);
x_2_max = floor(truck_height/box_width);
y_4_max = floor(truck_height/box_length);

for x1 = 0:1:x_1_max
   y1 = floor((truck_width - x1*box_width)/box_length);
   for x2 = 0:1:x_2_max
       y2 = floor((truck_height-x2*box_width)/box_length);
       for y4 =0:1:y_4_max
           x4 = floor((truck_height-y4*box_length)/box_width);
           if x2*box_width<=y4*box_length
               x3 = floor((truck_width-x1*box_width)/box_width);
               y3 = floor((truck_width-x3*box_width)/box_length);
           else
               x3 = round(y1*box_length/box_width);
               y3 = floor((truck_width-x3*box_width)/box_length);
               %�������룬���ǵ���������
           end
           %����ж�
           number_tmp = (x1*y4+x2*y1+x3*y2+x4*y3)*tier_height;
           if number<number_tmp
               number = number_tmp;
               sign = 3;
               number_tier = (x1*y4+x2*y1+x3*y2+x4*y3);
               tier = tier_height;
               x = [x1,x2,x3,x4];
               y = [y1,y2,y3,y4];
           end
       end
   end
end

end 