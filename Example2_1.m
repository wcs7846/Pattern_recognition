clc;
close all;
%这个是例2.1的实例程序
%Pe表示错误率--这个是错误率最低情况下最佳阈值确定
x=0:0.001:2;
N=length(x);
p1=0.5;
p2=0.5;
p_w1=(1/sqrt(pi))*exp(-(x.^2));
p_w2=(1/sqrt(pi))*exp(-((x-1).^2));
%x0=find(p_w1==p_w2);
Pe=400;
for x0=1:N
    temp=0.5*(sum(p_w1(x0:N))+sum(p_w2(1:x0)));
    Pe=[Pe,temp];
end
x0_Need=find(Pe==min(Pe));
%显示部分
figure(1);
plot(x,p_w1,'r.');hold on;
plot(x,p_w2,'b.');hold on;
line([x(x0_Need-1),x(x0_Need-1)],[0,max(p_w1)]);hold on;

%在存在损失矩阵时计算错误率最小的位置
%损失矩阵为L
L=[0 0.5;1.0 0];
Lamda11=L(1,1);
Lamda12=L(1,2);
Lamda21=L(2,1);
Lamda22=L(2,2);
L1=Lamda11*p_w1*p1+Lamda21*p_w2*p2;
L2=Lamda12*p_w1*p1+Lamda22*p_w2*p2;
L_diff=abs(L1-L2);
x1_Need=find(L_diff==min(L_diff));
%显示部分
figure(1);
%plot(x,p_w2,'r.');hold on;
%plot(x,p_w1,'b.');hold on;
plot(x,L1,'b.');hold on;
plot(x,L2,'r.');hold on;
line([x(x1_Need),x(x1_Need)],[0,max(max(L1),max(L2))]);hold on;

