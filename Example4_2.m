clc;
clear;
close all;
%---------------------------------------------------------------------------------------------------------
%程序说明：
%   ---本代码是用工具箱实现的神经网络训练，所以只能用来做测试使用，并不推荐作为原理学习使用
%   ---实现的神经网络训练为：
%   ---1.标准的梯度下降BP算法
%   ---2.动量BP算法
%   ---3.自适应学习率的BP算法
%---------------------------------------------------------------------------------------------------------
%产生数据集
randn('seed',0);
P1=[1  1];
m1=[1 8]';
m2=[8 1]';
sita=sqrt(4);
S1=(sita^2)*eye(2);
S2=S1;
N=1000;
x1_Source=mvnrnd(m1,S1,N);
x2_Source=mvnrnd(m2,S2,N);
x1=P1(1)*x1_Source;
x2=P1(2)*x2_Source;
figure(1);
%这里是显示的训练数据
plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
X1xlf=[x1(1:(N/2),:);x2(1:(N/2),:)];
%这里是显示的未训练数据
plot(x1_Source(((N/2)+1:N),1),x1_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
plot(x2_Source(((N/2)+1:N),1),x2_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
X1xln=[x1((N/2)+1:N,:);x2((N/2)+1:N,:)];
%
y=[ones(1,N/2),-ones(1,N/2)];
yF=[ones(1,N/2),-ones(1,N/2)];%这个是测试集的输出期望
%在第二个图中显示
figure(2);
plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
plot(x1_Source(((N/2)+1:N),1),x1_Source(((N/2)+1:N),2),'go','MarkerSize',5);hold on;
plot(x2_Source(((N/2)+1:N),1),x2_Source(((N/2)+1:N),2),'go','MarkerSize',5);hold on;
%---------------------------------------------------------------------------------------------------------
%具体实现的功能如下:
%条件
methods_list={'traingd';'traingdm';'traingda'};
limit=[min(X1xlf)',max(X1xlf)'];
%网络定义
net=newff(limit,[2 1],{'tansig','tansig'},...
    methods_list{1});
%网络初始化
net=init(net);
%参数设置
net.trainParam.epochs=10000;
net.trainParam.lr=0.5;
net.trainParam.lr_mc=0;
net.trainParam.lr_inc=0;
net.trainParam.max_perf_inc=0;
%网络训练 
net=train(net,X1xlf',y);
%网络测试
yT=sim(net,X1xln');
%---------------------------------------------------------------------------------------------------------
%根据网络结果进行分类
local=find(yT>0);
Fx1=X1xln(local,:);
yT(local)=1;
local=find(yT<=0);
Fx2=X1xln(local,:);
yT(local)=-1;
%标记
plot(Fx1(:,1),Fx1(:,2),'ro','MarkerSize',5);hold on;
plot(Fx2(:,1),Fx2(:,2),'bo','MarkerSize',5);hold on;
%---------------------------------------------------------------------------------------------------------
%计算分类的误差--即错误率
e=yF-yT;
local=find(e>0);
Re=length(local)/N;