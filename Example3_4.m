clc;
clear;
close all;
%这个是练习3.4的实例程序
%------ 这个算法是误差平方和最优线性分类器算法，以下为一些重要的说明：
%       1.这个算法能用在可以线性可分的分类问题中，也可以用在非线性可分中（会求出最小误差平方和时的权向量）
%       2.这个算法貌似并不需要循环，但是矩阵本身比较大
%---------------------------------------------------------------------------------------------------------
%产生数据集
randn('seed',0);
P1=[1  1];
m1=[8 1]';
m2=[1 8]';
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
%在第二个图中显示
figure(2);
plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
plot(x1_Source(((N/2)+1:N),1),x1_Source(((N/2)+1:N),2),'go','MarkerSize',5);hold on;
plot(x2_Source(((N/2)+1:N),1),x2_Source(((N/2)+1:N),2),'go','MarkerSize',5);hold on;
%---------------------------------------------------------------------------------------------------------
%{
%原始测试数据集---最开始用的数据(不打算删掉这个了留做纪念算了.....)
x1=[0.2 0.7;
    0.3 0.3;
    0.4 0.5;
    0.6 0.5;
    0.1 0.4];
x2=[0.4 0.6;
    0.6 0.2;
    0.7 0.4;
    0.8 0.6;
    0.7 0.5];
%---------------------------------------------------------------------------------------------------------
%画点
figure(1);
plot(x1(:,1),x1(:,2),'ro','MarkerSize',3);hold on;
plot(x2(:,1),x2(:,2),'bo','MarkerSize',3);hold on;
%}
%---------------------------------------------------------------------------------------------------------
%误差平方和估计----这个算法原理和实际计算都非常的方便（给设计这个算法的人点个赞）
y=[ ones(length(X1xlf(1:(N/2),:)),1);
   -ones(length(X1xlf((N/2+1:N),:)),1)];
x1F=[X1xlf(1:(N/2),:) ones(length(X1xlf(1:(N/2),:)),1)];
x2F=[X1xlf((N/2+1:N),:) ones(length(X1xlf((N/2+1:N),:)),1)];
%组合
X=[x1F;x2F];
%计算权向量
%------X'X为样本相关矩阵;
%------(X'X）^(-1)X为伪逆矩阵(只有在X'X可以转置的时候才可以这样弄)
w_N=(X'*X)^(-1)*X'*y;
%---------------------------------------------------------------------------------------------------------
%判断两个类的相对位置----以便后续的分类（只要是为了方便在画点的时候好涂颜色.......）
yPx1=sum(x1F(:,2))/length(x1F(:,2));
yPx2=sum(x2F(:,2))/length(x2F(:,2));
%进行分类操作
n1=X1xln(:,1);
n2=X1xln(:,2);
for n=1:1:length(n1)
    temp=(-w_N(1)*n1(n)-w_N(3))/w_N(2);
    if (yPx1>yPx2)
        if n2(n)<temp
            plot(n1(n),n2(n),'b+','MarkerSize',3);hold on;
        else
            plot(n1(n),n2(n),'r+','MarkerSize',3);hold on;
        end
    elseif (yPx1<yPx2)
        if n2(n)<temp
            plot(n1(n),n2(n),'r+','MarkerSize',3);hold on;
        else
            plot(n1(n),n2(n),'b+','MarkerSize',3);hold on;
        end     
    end
end
%---------------------------------------------------------------------------------------------------------
%画出权向量
minX=min(min(x1F(:,1)),min(x2F(:,1)));
maxX=max(max(x1F(:,1)),max(x2F(:,1)));
n1=minX:0.01:maxX;
n2=minX:0.01:maxX;
for n=1:1:length(n1)
    n2(n)=(-w_N(1)*n1(n)-w_N(3))/w_N(2);
end
plot(n1,n2,'k.','MarkerSize',3);hold on;
%---------------------------------------------------------------------------------------------------------
