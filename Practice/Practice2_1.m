clc;
clear;
close all;
%这个是练习2.1的实例程序--然而总觉得书上给的代码很不靠谱233
%结论的确是不靠谱--然而还是help靠谱
randn('seed',0);
m1=[1  1]';
m2=[7  7]';
m3=[15 1]';
S1=[12 0;0 1];
S2=[ 8 3;3 2];
S3=[ 2 0;0 2];
N=1000;
P1=[1/3,1/3,1/3];
x1_Source=mvnrnd(m1,S1,N);
x2_Source=mvnrnd(m2,S2,N);
x3_Source=mvnrnd(m3,S3,N);
x1=P1(1)*x1_Source;
x2=P1(2)*x2_Source;
x3=P1(3)*x3_Source;
figure(1);
subplot(121);
plot(x1(:,1),x1(:,2),'ro','MarkerSize',3);hold on;
plot(x2(:,1),x2(:,2),'bo','MarkerSize',3);hold on;
plot(x3(:,1),x3(:,2),'ko','MarkerSize',3);hold on;
P2=[0.6 0.3 0.1];
x1=P2(1)*x1_Source;
x2=P2(2)*x2_Source;
x3=P2(3)*x3_Source;
subplot(122);
plot(x1(:,1),x1(:,2),'ro','MarkerSize',3);hold on;
plot(x2(:,1),x2(:,2),'bo','MarkerSize',3);hold on;
plot(x3(:,1),x3(:,2),'ko','MarkerSize',3);hold on;

