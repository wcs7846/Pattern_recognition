clc;
clear;
close all;
%这个是例2.6的实例程序--由于中间的例子全部都是证明所以就算了
%本程序是来画一个图，用来展现当训练点的数量增加时，后验概率密度函数的变化情况
%{
基本设定：
    1.概率密度函数是一个单变量的高斯函数，均值未定.同时也服从高斯分布
    2.取得点数开心就好，随意
%}
%分布的参数
u0=2;
sita0=sqrt(8);
%数据分布的参数--利用随机数生成器来生成数据
sign=0;%标志位--为了使数据在一次u循环中只产生一次
N_All=[10,50,100,200,400];
for i=1:5;
    N=N_All(i);
    for u=1:0.001:4;
    sita=sqrt(4);
    %获得数据
    if sign==0
        DataSource=normrnd(u,(sita^2),[1 N]);
        sign=1;
    end
    %以下为计算
    Xn=1/N*(sum(DataSource));
    uN=(N*(sita0^2)*Xn+(sita^2)*u0)/(N*(sita0^2)+(sita^2));
    sitaN=sqrt(((sita0^2)*(sita^2))/(N*(sita0^2)+(sita^2)));
    p_u_x=1/(sqrt(2*pi)*sitaN)*exp(-(((u-uN)^2)/(2*(sitaN^2))));
    figure(1);plot(u,p_u_x,'r.');hold on;
    end
    sign=0;
end
%{
    通过图像可以看出虽然说的确是越来越尖锐了，但是这个u值却还是有很大的问题
%}
%{
u=1:0.001:9;
uN=2;
sitaN=sqrt(4);
p_u_x=1/(sqrt(2*pi)*sitaN)*exp(-(((u-uN).^2)/(2*(sitaN^2))));
figure(1);plot(u,p_u_x,'r.');hold on;
%}
