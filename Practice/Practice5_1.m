clc;
clear;
close all;
%这个是练习5.1的实例程序--这个程序等到把第6章的程序做完以后再做
%---------------------------------------------------------------------------------------------------------
%产生数据集
%   ---数据集的简要说明：
%   ---1.数据集不再是只有一个简单的高斯分布的点，会变得比以前复杂
%   ---2.数据集的数据不再是线性可分的，必然是非线性的，所以之前的线性分类器不能直接使用了
%   ---3.数据集总共还是1000个点，并且只有2个类
%   ---4.为了显示起来方便，所以现在每个样本的维数为2.因为2维比较好画图
randn('seed',0);
m1=0;
m2=2;
sita=sqrt(1);
S1=(sita^2)*eye(1);
S2=S1;
N1=100;
N2=100;
%填充随机数据---此处是假定m1==m2了，如果不一样是要分开的
x1=normrnd(m1,S1,[1,N1]);
x2=normrnd(m2,S2,[1,N2]);
figure(1);
%这里是显示的训练数据
n1=1:1:N1;
n2=1:1:N2;
plot(n1,x1,'b.');hold on;
plot(n2,x2,'r.');hold on;
%---------------------------------------------------------------------------------------------------------
%特征生成
%----准备调用函数来偷懒

%---------------------------------------------------------------------------------------------------------
%特征检验
%----采用的方式为t检测来校验
