clc;
clear;
close all;
%这个是练习3.3的实例程序
%------ 这个算法是采用Kesler结构的感知器算法，以下为一些重要的说明：
%       1.这个算法只能用在可以线性可分的分类问题中
%       2.这个算法会无限次循环下去，直到找到一个可以完全分类的权向量
%---------------------------------------------------------------------------------------------------------
%{
%产生数据集
randn('seed',0);
P1=[1  1];
m1=[1 14]';
m2=[14 1]';
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
%}
%---------------------------------------------------------------------------------------------------------
%原始数据
x1=[ 1  1; 2  2; 2  1];
x2=[ 1 -1; 1 -2; 2 -2];
x3=[-1  1;-1  2;-2  1];
%扩展向量
x0=zeros(1,length(x1(1,:))+1);%定义一个空的
Kx1=[x1(1,:),1];
Kx2=