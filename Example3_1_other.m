clc;
clear;
close all;
%这个是练习3.1的实例程序---还是利用之前的例子来做感知器算法
%这次的感知器算法是经过改进的版本
%------主要是添加了奖励和惩罚方案
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
%---------------------------------------------------------------------------------------------------------
x0=1/N*sum(X1xlf);
plot(x0(1),x0(2),'g+','MarkerSize',7);hold on;
%假定权向量为[1 1 b]--b为根据x0求出来的值
b=0;%这个是初始值
w0=[1 1 b];
b=-w0(1)*x0(1)-w0(2)*x0(2);
w0=[1 1 b];
%---------------------------------------------------------------------------------------------------------
%画出权向量
n1=X1xlf(:,1)';
n2=-5:(25/(length(n1)-1)):20;
for n=1:1:length(n1)
    n2(n)=(-w0(1)*n1(n)-w0(3))/w0(2);
end
plot(n1,n2,'g.','MarkerSize',3);hold on;
%---------------------------------------------------------------------------------------------------------
%感知器算法
%权向量的形式为：ax1+bx2+c=0<---->w=[a,b,c]'
%计算系数siertax
ww1=[x1,ones(size(x1,1),1)]; 
ww2=[x2,ones(size(x2,1),1)]; 
X=[ww1;-ww2];
W=w0';
%W=ones(size(X,2),1);
ok=0;
%初始化基本参数
Ro=0.05;
Rot=Ro;
k=1;%这个数是用来调试的
%循环体
while(ok==0)
    for n=1:size(X,1)
        if (W'*X(n,:)'<0) 
            k=k+1;
            W=W+Ro*X(n,:)';
            break;
%         elseif (W'*X(n,:)'>0)&&(X(n,3)==-1) 
%             k=k+1;
%             W=W-Ro*X(n,:)';
%             break;
        else
            %W=W; %这里写出来只是表达一下算法的细节而且，实际操作的时候是没有意义的
            if (n==size(X,1)) 
                ok=1;
            end
        end
    end
end
%重新画一下直线
%n1=X1xlf(:,1)';
n2=-W(1)*n1/W(2)-W(3)/W(2); 
plot(n1,n2,'m.','MarkerSize',3);hold on;
%---------------------------------------------------------------------------------------------------------
%利用权向量进行分类
nfx1=X1xln(:,1)';
nfx2=X1xln(:,2)';
for n=1:1:length(nfx1)
    if m1(2)>m2(2)
        if nfx2(n)>n2(n)
            plot(nfx1(n),nfx2(n),'r+','MarkerSize',3);hold on;
        else
            plot(nfx1(n),nfx2(n),'b+','MarkerSize',3);hold on;
        end
    else
        if nfx2(n)<n2(n)
            plot(nfx1(n),nfx2(n),'r+','MarkerSize',3);hold on;
        else
            plot(nfx1(n),nfx2(n),'b+','MarkerSize',3);hold on;
        end
    end
end
%---------------------------------------------------------------------------------------------------------
%{
%判断权向量是否为正确分类
FalseX1=0;
for n=1:1:length(n1)/2
    if X1xlf(n,2)>n2(n)
        FalseX1=[FalseX1,n];
        plot(X1xlf(n,1),X1xlf(n,2),'mo','MarkerSize',5);
    end
end
FalseX2=0;
for n=length(n1)/2+1:1:length(n1)
    if X1xlf(n,2)<n2(n)
        FalseX2=[FalseX2,n];
        plot(X1xlf(n,1),X1xlf(n,2),'mo','MarkerSize',5);
    end
end
%整理一下出错的数据
Wx1=ones(length(FalseX1)-1,3);
for n=1:length(FalseX1)-1
    Wx1(n,1:2)=X1xlf(FalseX1(n+1),:);
end
Wx2=ones(length(FalseX2)-1,3);
for n=1:length(FalseX2)-1
    Wx2(n,1:2)=X1xlf(FalseX2(n+1),:);
end
%}
%---------------------------------------------------------------------------------------------------------
