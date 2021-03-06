clc;
close all;
clear;
%------------------------------------------------------------------------
%这个程序是用来做模糊技术进行灰度变换的
src=imread('D:\Matlab_Program\MatlabPictureLearing\test1\Test.jpg');
dst=rgb2gray(src);
figure(1);imshow(dst,[]);hold on;
title('原始灰度图');
%------------------------------------------------------------------------
I=imhist(dst);
figure(2);bar(I);hold on;
xlim([0,256]);
title('原始直方图');
%------------------------------------------------------------------------
%进行图像处理
%   直方图均衡化处理
dstF=histeq(dst);
figure(3);imshow(dstF);hold on;
title('直方图均衡化后');
IF=imhist(dstF);
figure(4);bar(IF);hold on;
xlim([0,256]);
title('均衡化后直方图');
%------------------------------------------------------------------------
%   模糊技术灰度变换
%模糊化的对比度增强过程为：
%----IF一个像素是暗的，THEN使它较暗
%----IF一个像素是灰的，THEN使它仍是灰的
%----IF一个像素是亮的，THEN使它较亮
%--------------------------------
%   先计算3条隶属度函数--并且画出来
%   已经测试完毕了
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
title('隶属函数');
xlim([0,256]);
%-------------------------------
%设置输出单一值
v_dark=0;
v_gray=127;
v_bright=255;
%遍历图像计算输出
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
title('模糊技术处理后图像');
dstO2=mat2gray(dstO);
IO=imhist(dstO2);
figure(7);bar(IO);hold on;
xlim([0,256]);
title('模糊技术处理后直方图');
%--------------
%确实是可以用的，效果很不错，就是有点慢
