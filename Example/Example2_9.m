clc;
clear;
close all;
%这个是例2.9的实例程序--已经完成
%绘制网格
t = 0:0.1:1.5;
M=meshgrid(t,t);
figure(1);
plot(t,M,'k','LineWidth',0.5);hold on;
plot(M,t,'k','LineWidth',0.5);hold on;
%绘制1号类w1的点
w1=[0.1 0.4;0.1 0.5;0.1 0.6;0.1 0.7;0.1 0.8;0.1 1.0;
    0.2 0.2;0.2 0.3;0.2 0.4;0.2 0.5;0.2 0.6;0.2 0.7;0.2 0.8;0.2 0.9;0.2 1.0;0.2 1.1;
    0.3 0.1;0.3 0.2;0.3 0.3;0.3 0.4;0.3 0.5;0.3 0.6;0.3 0.7;0.3 0.8;0.3 0.9;0.3 1.0;
    0.4 0.1;0.4 0.2;0.4 0.3;0.4 0.4;0.4 0.5;0.4 0.6;0.4 0.7;0.4 0.9;0.4 1.0;0.4 1.1;0.4 1.2;0.4 1.3;
    0.5 0.1;0.5 0.3;0.5 0.4;0.5 0.5;0.5 0.5;0.5 0.6;0.5 0.7;0.5 0.8;0.5 0.9;0.5 1.1;0.5 1.2;
    0.6 0.4;0.6 0.5;0.6 0.6;0.6 0.7;0.6 0.8;0.6 0.9;0.6 1.0;0.6 1.1;0.6 1.2
    0.7 0.7;0.7 0.8;
    0.8 0.6;
    1.0 1.2;];
w2=[0.4 0.8;
    0.7 0.5;
    0.8 0.4;0.8 0.7;0.8 1.0;
    0.9 0.6;0.9 0.8;0.9 1.0;0.9 1.2;
    1.0 0.2;1.0 0.3;1.0 0.4;1.0 0.5;1.0 0.6;1.0 0.7;1.0 0.8;1.0 0.9;1.0 1.0;1.0 1.1;
    1.1 0.3;1.1 0.4;1.1 0.5;1.1 0.6;1.1 0.7;1.1 0.8;1.1 0.9;1.1 1.0;1.0 1.1;1.1 1.1;1.1 1.2;
    1.2 0.1;1.2 0.2;1.2 0.3;1.2 0.4;1.2 0.5;1.2 0.6;1.2 0.7;1.2 0.8;1.2 0.9;1.2 1.0;1.2 1.1;1.2 1.1;1.2 1.3;
    1.3 0.2;1.3 0.3;1.3 0.4;1.3 0.5;1.3 0.6;1.3 0.7;1.3 0.8;1.3 0.9;1.3 1.0;1.3 1.1;1.3 1.1;
    1.4 0.3;1.4 0.4;1.4 0.5;1.4 0.6;1.4 0.7;1.4 0.8;1.4 0.9;1.4 1.0;];
x1=w1(:,1);
y1=w1(:,2);
x2=w2(:,1);
y2=w2(:,2);
plot(x1,y1,'r.','MarkerSize',20);hold on;
plot(x2,y2,'b.','MarkerSize',20);hold on;
%绘制星号坐标位置
w0=[0.7 0.6];
%w0=[1.5/2*rand(1)+1.5/4,1.5/4*rand(1)+1.5/2];
x0=w0(:,1);
y0=w0(:,2);
plot(x0,y0,'g*','MarkerSize',10);hold on;
%k值定义
k=5;
Rol_1=0:1:length(x1)-1;
Rol_2=0:1:length(x2)-1;
%计算距离--采用最原始的方案，计算所有的点与星号位置的距离
for n=1:length(x1)
    Rol_1(n) = (x1(n)-x0)^2+(y1(n)-y0)^2;
    Rol_2(n) = (x2(n)-x0)^2+(y2(n)-y0)^2;
end
w1=[w1,Rol_1'];
w2=[w2,Rol_2'];
%标定1号类和星号的位置关系
kRemind1=k;
while kRemind1>0
    x=find(Rol_1==min(Rol_1));
    kRemind1=kRemind1-length(x);
    Rol_1(x)=max(Rol_1);
end
GoalxFor1=w1(x(1),1);
GoalyFor1=w1(x(1),2);
GoalrFor1=w1(x(1),3);
plot(GoalxFor1,GoalyFor1,'ro','MarkerSize',10);hold on;
%标定2号类和星号的位置关系
kRemind2=k;
while kRemind2>0
    x=find(Rol_2==min(Rol_2));
    kRemind2=kRemind2-length(x);
    Rol_2(x)=max(Rol_2);
end
GoalxFor2=w2(x(1),1);
GoalyFor2=w2(x(1),2);
GoalrFor2=w2(x(1),3);
plot(GoalxFor2,GoalyFor2,'bo','MarkerSize',10);hold on;
%画圆圈
rd=pi/180;
for n=1:1:360
    CircleX=x0+sqrt(GoalrFor1)*cos(n*rd);
    CircleY=y0+sqrt(GoalrFor1)*sin(n*rd);
    plot(CircleX,CircleY,'r.','MarkerSize',0.5);hold on;
    CircleX=x0+sqrt(GoalrFor2)*cos(n*rd);
    CircleY=y0+sqrt(GoalrFor2)*sin(n*rd);
    plot(CircleX,CircleY,'b.','MarkerSize',0.5);hold on;
end

