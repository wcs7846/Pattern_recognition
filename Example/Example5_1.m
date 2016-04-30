clc;
clear;
close all;
%这个是一个实验程序
%---这个算法是数据归一化的，以下为一些重要的说明：
%---主要是用来试一下数据归一化的效果
%   1.下面是采用softmax比例的算法，即将数据归一化后使之具有零均值和单位方差
%---------------------------------------------------------------------------------------------------------
%产生数据集
m1=[0.4 0.9;
    2.0 1.8;
    2.3 2.3;
    2.6 1.8];
m2=[1.5 1.0;
    1.9 1.0;
    1.5 3.0;
    3.3 2.6];
P1=[1  1];
sita=sqrt(4);
si=[12 0;0 1];
S1=(sita^2)*si;
S2=S1;
N=1000;
x1_Source=mvnrnd(m1(1,:),S1,N);
x2_Source=mvnrnd(m2(1,:),S2,N);
x1=P1(1)*x1_Source;
x2=P1(2)*x2_Source;
figure(1);
%这里是显示的训练数据
plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
%plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
X1xlf=[x1(1:(N/2),:);x2(1:(N/2),:)];
%这里是显示的未训练数据
%plot(x1_Source(((N/2)+1:N),1),x1_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
%plot(x2_Source(((N/2)+1:N),1),x2_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
X1xln=[x1((N/2)+1:N,:);x2((N/2)+1:N,:)];
%在第二个图中显示
%figure(2);
%plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
%plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
%---------------------------------------------------------------------------------------------------------
%计算必要参数
xMean=sum(x1(1:length(x1),:))/length(x1);
temp=zeros(1,2);
for n=1:length(x1)
    temp=temp+(x1(n,:)-xMean).^2;
end
xSita=sqrt(temp/(length(x1)-1));
%---------------------------------------------------------------------------------------------------------
%softmax比例变换
y=zeros(size(x1));
r=4;
for n=1:length(x1)
    y(n,:)=(x1(n,:)-xMean)./(r*xSita);
end
xNorm=1./(1+exp(-y));
%---------------------------------------------------------------------------------------------------------
plot(y(:,1),y(:,2),'bo','MarkerSize',3);hold on;
figure(2);
plot(y(:,1),y(:,2),'bo','MarkerSize',3);hold on;