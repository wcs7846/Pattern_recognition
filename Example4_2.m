clc;
clear;
close all;
%---------------------------------------------------------------------------------------------------------
%程序说明：
%   ---本代码是用工具箱实现的神经网络训练，所以只能用来做测试使用，并不推荐作为原理学习使用
%   ---实现的神经网络训练为：
%   ---1.标准的梯度下降BP算法(下面实现的就是这个)
%   ---2.动量BP算法
%   ---3.自适应学习率的BP算法
%---------------------------------------------------------------------------------------------------------
%产生数据集
randn('seed',0);
P1=[1  1  1  1];
m1=[1 10]';
m2=[10 1]';
m3=[10,10]';
%m4=[1, 1]';
sita=sqrt(2);
S1=(sita^2)*eye(2);
S2=S1;
S3=S1;
%S4=S1;
N=1000;
x1_Source=mvnrnd(m1,S1,N);
x2_Source=mvnrnd(m2,S2,N);
x3_Source=mvnrnd(m3,S3,N);
%x4_Source=mvnrnd(m4,S4,N);
x1=P1(1)*x1_Source;
x2=P1(2)*x2_Source;
x3=P1(3)*x3_Source;
%x4=P1(4)*x4_Source;
figure(1);
%这里是显示的训练数据
plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
plot(x3_Source((1:N/2),1),x3_Source((1:N/2),2),'ko','MarkerSize',3);hold on;
%plot(x4_Source((1:N/2),1),x4_Source((1:N/2),2),'yo','MarkerSize',3);hold on;
X1xlf=[x1(1:(N/2),:);x2(1:(N/2),:);x3(1:(N/2),:)];
%这里是显示的未训练数据
plot(x1_Source(((N/2)+1:N),1),x1_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
plot(x2_Source(((N/2)+1:N),1),x2_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
plot(x3_Source(((N/2)+1:N),1),x3_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
%plot(x4_Source(((N/2)+1:N),1),x4_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
X1xln=[x1((N/2)+1:N,:);x2((N/2)+1:N,:);x3(((N/2)+1):N,:)];
%{
     1---1号类
    -1---2号类
     0---3号类
%}
y=[ones(1,N/2),-ones(1,N/2),zeros(1,N/2)];%这个是测试集的输出期望
%在第二个图中显示
figure(2);
plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
plot(x3_Source((1:N/2),1),x3_Source((1:N/2),2),'ko','MarkerSize',3);hold on;
%plot(x4_Source((1:N/2),1),x4_Source((1:N/2),2),'yo','MarkerSize',3);hold on;
plot(x1_Source(((N/2)+1:N),1),x1_Source(((N/2)+1:N),2),'go','MarkerSize',3);hold on;
plot(x2_Source(((N/2)+1:N),1),x2_Source(((N/2)+1:N),2),'go','MarkerSize',3);hold on;
plot(x3_Source(((N/2)+1:N),1),x3_Source(((N/2)+1:N),2),'go','MarkerSize',3);hold on;
%plot(x4_Source(((N/2)+1:N),1),x4_Source(((N/2)+1:N),2),'go','MarkerSize',3);hold on;
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
net.trainParam.epochs=1000;
net.trainParam.lr=0.5;
net.trainParam.lr_mc=0;
net.trainParam.lr_inc=0;
net.trainParam.max_perf_inc=0;
%网络训练 
net=train(net,X1xlf',y);
%网络测试
yT=sim(net,X1xln');
TestResult=yT;
yT=round(TestResult);
%---------------------------------------------------------------------------------------------------------
%根据网络结果进行分类
%标记
for n=1:length(yT)
    if yT(1,n)==1
        plot(X1xln(n,1),X1xln(n,2),'ro','MarkerSize',3);hold on;
    elseif yT(1,n)==-1
        plot(X1xln(n,1),X1xln(n,2),'bo','MarkerSize',3);hold on;
    elseif yT(1,n)==0
        plot(X1xln(n,1),X1xln(n,2),'ko','MarkerSize',3);hold on;
    end
end
%---------------------------------------------------------------------------------------------------------
%计算分类的误差--即错误率
Ne=0;
for n=1:length(X1xln)
    if yT(n)~=y(n)
        Ne=Ne+1;
    end
end
Re=Ne/length(X1xln);