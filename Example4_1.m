clc;
clear;
close all;
%这个是练习3.5的实例程序
%------ 这个算法是BP神经网络算法，以下为一些重要的说明：
%---------------------------------------------------------------------------------------------------------
%产生数据集
%   ---数据集的简要说明：
%   ---1.数据集不再是只有一个简单的高斯分布的点，会变得比以前复杂
%   ---2.数据集的数据不再是线性可分的，必然是非线性的，所以之前的线性分类器不能直接使用了
%   ---3.数据集总共还是1000个点，并且只有2个类
randn('seed',0);
P1=[1  1];
m1=[0.4 0.9;
    2.0 1.8;
    2.3 2.3;
    2.6 1.8];
m2=[1.5 1.0;
    1.9 1.0;
    1.5 3.0;
    3.3 2.6];
sita=sqrt(0.01);
S1=(sita^2)*eye(2);
S2=S1;
N=400;
%创建存放位置
x1_Source=zeros(N,2);
x2_Source=zeros(N,2);
X1xlf=zeros(N,2);
X1xln=zeros(N,2);
%创建临时位置
x1_Stemp=zeros(floor(N/length(m1)),2);
x2_Stemp=zeros(floor(N/length(m2)),2);
%填充随机数据---此处是假定m1==m2了，如果不一样是要分开的
for n=1:length(m1)
    x1_Stemp=mvnrnd(m1(n,:),S1,floor(N/length(m1)));
    x2_Stemp=mvnrnd(m2(n,:),S2,floor(N/length(m2)));
    x1_Source((n-1)*floor(N/length(m1))+1:n*floor(N/length(m1)),:)=x1_Stemp;
    x2_Source((n-1)*floor(N/length(m2))+1:n*floor(N/length(m2)),:)=x2_Stemp;
    X1xlf((n-1)*floor(N/length(m1))/2+1:n*floor(N/length(m1))/2,:)=x1_Stemp(1:(floor(N/length(m1)))/2,:);
    X1xlf((n-1)*floor(N/length(m2))/2+1+N/2:n*floor(N/length(m2))/2+N/2,:)=x2_Stemp(1:(floor(N/length(m2)))/2,:);
    X1xln((n-1)*floor(N/length(m1))/2+1:n*floor(N/length(m1))/2,:)=x1_Stemp((floor(N/length(m1)))/2+1:floor(N/length(m1)),:);
    X1xln((n-1)*floor(N/length(m2))/2+1+N/2:n*floor(N/length(m2))/2+N/2,:)=x2_Stemp((floor(N/length(m2)))/2+1:floor(N/length(m2)),:);
end
x1=P1(1)*x1_Source;
x2=P1(2)*x2_Source;
figure(1);
%这里是显示的训练数据
plot(X1xlf(1:(floor(N/length(m1)))/2,1),X1xlf(1:(floor(N/length(m1)))/2,2),'ro','MarkerSize',3);hold on;
plot(X1xlf((floor(N/length(m1)))/2+1:floor(N/length(m1)),1),X1xlf((floor(N/length(m1)))/2+1:floor(N/length(m1)),2),'bo','MarkerSize',3);hold on;
%---------------------------------------------------------------------------------------------------------
%神经网络的结构说明：
%   ---1.采“用输入层-隐含层-输出层”的结构
%   ---2.输入层的数量为1，隐含层的数量为1，输出层的数量为1
%   ---3.采用反向传播的算法而不是反馈神经网络
%   ---4.这个最初始的版本里面是没有加动力项等特技的，所以可能陷入各种各样的局部最小
%使用的变量说明：
%   ---1.输入向量：x
%   ---2.隐层输出：y
%   ---3.实际输出：O
%   ---4.期望输出：d
%   ---5.权值向量：V
%                 W
%-------------------
%权值初始化---使用均值分布在[0,1]的数




