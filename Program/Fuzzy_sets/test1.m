clc;
close all;
clear;
%------------------------------------------------------------------------
%���������������ģ���������лҶȱ任��
src=imread('D:\Matlab_Program\MatlabPictureLearing\test1\Test.jpg');
dst=rgb2gray(src);
figure(1);imshow(dst,[]);hold on;
title('ԭʼ�Ҷ�ͼ');
%------------------------------------------------------------------------
I=imhist(dst);
figure(2);bar(I);hold on;
xlim([0,256]);
title('ԭʼֱ��ͼ');
%------------------------------------------------------------------------
%����ͼ����
%   ֱ��ͼ���⻯����
dstF=histeq(dst);
figure(3);imshow(dstF);hold on;
title('ֱ��ͼ���⻯��');
IF=imhist(dstF);
figure(4);bar(IF);hold on;
xlim([0,256]);
title('���⻯��ֱ��ͼ');
%------------------------------------------------------------------------
%   ģ�������Ҷȱ任
%ģ�����ĶԱȶ���ǿ����Ϊ��
%----IFһ�������ǰ��ģ�THENʹ���ϰ�
%----IFһ�������ǻҵģ�THENʹ�����ǻҵ�
%----IFһ�����������ģ�THENʹ������
%--------------------------------
%   �ȼ���3�������Ⱥ���--���һ�����
%   �Ѿ����������
z0=0:1:255;
point_Dark=[4 , 1;
         34, 0;];
point_Gray=[4 , 0;
         34, 1;
         64, 0;];
point_Bright=[34, 0;
         64, 1;];
parameter_Dark=Membership_Degree_Parameter(point_Dark);
parameter_Gray=Membership_Degree_Parameter(point_Gray);
parameter_Bright=Membership_Degree_Parameter(point_Bright);
y_dark=0:1:255;
y_gray=0:1:255;
y_bright=0:1:255;
for n=1:256
    y_dark(n)=PiecewiseFunction(z0(n),parameter_Dark,point_Dark);
    y_gray(n)=PiecewiseFunction(z0(n),parameter_Gray,point_Gray);
    y_bright(n)=PiecewiseFunction(z0(n),parameter_Bright,point_Bright);
end
figure(5);
plot(z0,y_dark,'-b');hold on;
plot(z0,y_gray,'-r');hold on;
plot(z0,y_bright,'-k');hold on;
title('��������');
xlim([0,256]);
%-------------------------------
%���������һֵ
v_dark=0;
v_gray=127;
v_bright=255;
%����ͼ��������
[row,col]=size(dst);
dstO=zeros(row,col);
for nx=1:row
    for ny=1:col
        temp_d=PiecewiseFunction(double(dst(nx,ny)),parameter_Dark,point_Dark);
        temp_g=PiecewiseFunction(double(dst(nx,ny)),parameter_Gray,point_Gray);
        temp_b=PiecewiseFunction(double(dst(nx,ny)),parameter_Bright,point_Bright);
        dstO(nx,ny)=(temp_d*v_dark+temp_g*v_gray+temp_b*v_bright)/(temp_d+temp_g+temp_b);
    end
end
figure(6);imshow(dstO,[]);hold on;
title('ģ�����������ͼ��');
dstO2=mat2gray(dstO);
IO=imhist(dstO2);
figure(7);bar(IO);hold on;
xlim([0,256]);
title('ģ�����������ֱ��ͼ');
%--------------
%ȷʵ�ǿ����õģ�Ч���ܲ��������е���
