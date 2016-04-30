clc;
clear;
close all;
%---------------------------------------------------------------------------------------------------------
%这个文件主要是用来写一个二次规划的算法的----在SVM中要用到，所以这里做一下
%---------------------------------------------------------------------------------------------------------
%采用最为原始的方式做的二次规划
%即采用的穷举法实现的
x1=0:0.001:1.6;%此处不能再加一位
x2=x1;
%画出边界线
%figure(1);
xBound1=-x1+2;
%plot(x1,xBound1,'-b');hold on;
xBound2=(x1+2)/2;
%plot(x1,xBound2,'-b');hold on;
xBound3=-2*x1+3;
%plot(x1,xBound3,'-b');hold on;
%xlim([0,1.6]);ylim([0,1.4]);
%计算BlackG
By=min(x1):1.6/(length(x1)-1):max(x1);
BlackG=zeros(length(x1),length(x2));
for nx=1:length(x1)
    for ny=1:length(x2)
        if (By(ny)<=xBound1(nx))&&(By(ny)<=xBound2(nx))&&(By(ny)<=xBound3(nx))
            BlackG(nx,ny)=1;
        else
            BlackG(nx,ny)=0;
        end
    end
end
%figure(2);
%imshow(BlackG);hold on;%显示出边界范围
%计算f(x)
fo=zeros(length(x1),length(x2));
for nx=1:length(x1)
    for ny=1:length(x2)
        fo(nx,ny)=1/2*x1(nx)^2+x2(ny)^2-x1(nx)*x2(ny)-2*x1(nx)-6*x2(ny);
    end
end
finf=BlackG.*fo;
[Posx,Posy]=find(finf==min(min(finf)));
%在边界上把点标记一下
%figure(2);plot(Posy,Posx,'r*');hold on;
minf=finf(Posx,Posy);
%---------------------------------------------------------------------------------------------------------
%以下为采用quadprod函数来进行的二次规划
%{
H=[ 1 -1;
   -1  2];
f=[-2; 
   -6];
A=[ 1  1;
   -1  2;
    2  1;];
b=[ 2;
    2;
    3;];
lb=[0;
    0;];
[x,fval,exitflag,output,lambda] = quadprog(H,f,A,b,[],[],lb);
%}