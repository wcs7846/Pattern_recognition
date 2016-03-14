clc;
clear;
close all;
%这个是练习3.5的实例程序
%------ 这个算法是SVM分类器算法，以下为一些重要的说明：
%       1.这个貌似是必须要使用二次规划的函数的，不然根本没有办法做--真是残念(如果要用C++实现的话，只能去找一些二次规划的库看看了)
%       2.但是这个程序还是不会直接用工具箱去实现SVM的不然就太无趣了
%       3.现在实现的SVM算法是做的可分的类的情况，之后可能会修改成不可分的类的情况或者多类的情况
%---------------------------------------------------------------------------------------------------------
%产生数据集
randn('seed',0);
P1=[1  1];
m1=[1 8]';
m2=[8 1]';
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
plot(x1_Source(((N/2)+1:N),1),x1_Source(((N/2)+1:N),2),'mo','MarkerSize',5);hold on;
plot(x2_Source(((N/2)+1:N),1),x2_Source(((N/2)+1:N),2),'mo','MarkerSize',5);hold on;
%---------------------------------------------------------------------------------------------------------
%构建y向量
y=[ones(N/2,2); -ones(N/2,2)];
%构建约束上限系数
c=0.2;
%---------------------------------------------------------------------------------------------------------
%由于要使用quadprog优化函数来进行二次规划的求解，所以以下为计算需要输入的矩阵
%   ---需要计算的矩阵有：
%   ---1.公式参数矩阵：H f 
%   ---2.约束参数矩阵：A b Aeq beq lb ub
H=-0.5*(X1xlf.*y)*(X1xlf'.*y');
f=ones(N,1);
%A为空
%b为空
Aeq=[ones(1,N/2),-ones(1,N/2)];
beq=0;
lb=zeros(N,1);
ub=c*ones(N,1);
%使用quadprog函数来确定最佳的拉格朗日乘子参数
[lameda,fval] = quadprog(H,f,[],[],Aeq,beq,lb,ub);
%---------------------------------------------------------------------------------------------------------
%计算决策面
w=sum([lameda,lameda].*(y.*X1xlf));
w0=sum(X1xlf)/N;
%---------------------------------------------------------------------------------------------------------
%画出决策面
b=-(w*w0');
minX=min(min(X1xlf));
maxX=max(max(X1xlf));
n1=minX:0.01:maxX;
n2=minX:0.01:maxX;
for n=1:1:length(n1)
    n2(n)=(-w(1)*n1(n)-b)/w(2);
end
plot(n1,n2,'k.','MarkerSize',3);hold on;
%---------------------------------------------------------------------------------------------------------
%计算类分离面的位置
bL1=1-w*w0';
bL2=-1-w*w0';
nbL1=minX:0.01:maxX;
nbL2=minX:0.01:maxX;
for n=1:1:length(n1)
    nbL1(n)=(-w(1)*n1(n)-bL1)/w(2);
    nbL2(n)=(-w(1)*n1(n)-bL2)/w(2);
end
%画出类分段面 
plot(n1,nbL1,'k.','MarkerSize',3);hold on;
plot(n1,nbL2,'k.','MarkerSize',3);hold on;
%---------------------------------------------------------------------------------------------------------
%判断两个类的相对位置----以便后续的分类（只要是为了方便在画点的时候好涂颜色.......）
x1F=X1xlf(1:(N/2),:);
x2F=X1xlf((N/2+1:N),:);
yPx1=sum(x1F(:,2))/length(x1F(:,2));
yPx2=sum(x2F(:,2))/length(x2F(:,2));
%进行分类操作
n1=X1xln(:,1);
n2=X1xln(:,2);
for n=1:1:length(n1)
    temp=(-w(1)*n1(n)-b)/w(2);
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
