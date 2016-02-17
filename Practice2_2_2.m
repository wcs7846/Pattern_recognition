clc;
clear;
close all;
%这个是练习2.2的实例程序---由于代码本身比较长而且又不打算封装成函数所以就直接写在两个脚本里面了
%(a)X1数据集的生成
randn('seed',0);
P1=[1/3,1/3,1/3];
m1=[1  1]';
m2=[12 8]';
m3=[16 1]';
sita=sqrt(4);
S1=(sita^2)*eye(2);
S2=S1;
S3=S1;
N=1000;
x1_Source=mvnrnd(m1,S1,N);
x2_Source=mvnrnd(m2,S2,N);
x3_Source=mvnrnd(m3,S3,N);
x1=P1(1)*x1_Source;
x2=P1(2)*x2_Source;
x3=P1(3)*x3_Source;
figure(1);
plot(x1_Source(:,1),x1_Source(:,2),'ro','MarkerSize',3);hold on;
plot(x2_Source(:,1),x2_Source(:,2),'bo','MarkerSize',3);hold on;
plot(x3_Source(:,1),x3_Source(:,2),'ko','MarkerSize',3);hold on;
X1=[x1;x2;x3];
%---------------------------------------------------------------------------------------------------------
%(b)欧几里得距离


