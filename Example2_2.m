clc;
clear;
close all;
%这个是例2.2的实例程序--由于这个不好画图所以直接看数字
u1=[0 0]';
u2=[3 3]';
sigma=[1.1 0.3;0.3 1.9];%这个是协方差矩阵
sign=0;%0--表示没有分类；1--表示分到1号类中；2--表示分到2号类中
%(a)根据贝叶斯分类器对向量x分类（x在下面给出）--判据利用马氏距离来判断
x=[1.0 2.2]';
dm_u1_x=sqrt((x-u1)'*(inv(sigma))*(x-u1));
dm_u2_x=sqrt((x-u2)'*(inv(sigma))*(x-u2));
if dm_u1_x>dm_u2_x
    sign=2;
end
if dm_u1_x<=dm_u2_x
    sign=1;
end
