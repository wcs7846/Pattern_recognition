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
%   �ȼ���3�������Ⱥ���
%   �Ѿ����������
z0=0:1:255;
y_dark=0:1:255;
y_gray=0:1:255;
y_bright=0:1:255;
for n=1:256
    y_dark(n)=u_dark(z0(n));
    y_gray(n)=u_gray(z0(n));
    y_bright(n)=u_bright(z0(n));
end
figure(5);
plot(z0,y_dark,'-b');hold on;
plot(z0,y_gray,'-r');hold on;
plot(z0,y_bright,'-k');hold on;
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
        temp_d=u_dark(double(dst(nx,ny)));
        temp_g=u_gray(double(dst(nx,ny)));
        temp_b=u_bright(double(dst(nx,ny)));
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
