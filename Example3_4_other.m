clc;
clear;
close all;
%这个是例3.4的实例程序
%------ 这个算法是LMS算法，以下为一些重要的说明：
%       1.这个算法是在感知器算法的基础上改进的所以和感知器算法很相像
%       2.这个算法需要大量的循环所以会有点慢
%---------------------------------------------------------------------------------------------------------
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
%LMS算法
%权向量的形式为：ax1+bx2+c=0<---->w=[a,b,c]'
%采用迭代的方法来W(k)=W(k-1)+Ro(k)*x(k)(y(k)-x(k)'*w(k-1))
%采用的Ro(k)=1/k;
%设定误差灵敏度为1
%初始化
W=w0;
Sigema=0.0001;
ok=0;
Ro=1:length(X1xlf);
for n=1:length(Ro)
    Ro(n)=1/n;
end
Y1xlf=[ones(N/2,1);-ones(N/2,1)];%期望输出
X1xlfC=[X1xlf,ones(length(X1xlf),1)];
%调试用
XiuZhenZ=zeros(length(Y1xlf),3);
XiuFuZ=zeros(length(Y1xlf),3);
while(ok==0)
    for n=1:length(X1xlf)
        temp = Ro(n)*X1xlfC(n,:)*(Y1xlf(n)-X1xlfC(n,:)'*W);
        
%         if abs(temp)<Sigema
%             ok=1;
%             break;
%         end
        
        XiuZhenZ(n,:)=temp;
        W=W+temp;
        XiuFuZ(n,:)=W;
    end
    ok=1;
end
%重新画一下直线
n2=-W(1)*n1/W(2)-W(3)/W(2); 
plot(n1,n2,'m.','MarkerSize',3);hold on;
%---------------------------------------------------------------------------------------------------------
%利用权向量进行分类
%{
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
%}
%---------------------------------------------------------------------------------------------------------