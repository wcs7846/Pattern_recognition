clc;
clear;
close all;
%这个是练习2.2的实例程序---由于代码本身比较长而且又不打算封装成函数所以就直接写在两个脚本里面了
%(a)X1数据集的生成
randn('seed',0);
P1=[1,1,1];%这里本来应该是1/3的，但是考虑到为概率相等所以用1代替--好计算
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
%这里是显示的训练数据
plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
plot(x3_Source((1:N/2),1),x3_Source((1:N/2),2),'ko','MarkerSize',3);hold on;
X1xlf=[x1(1:(N/2),:);x2(1:(N/2),:);x3(1:(N/2),:)];
%这里是显示的未训练数据
plot(x1_Source(((N/2)+1:N),1),x1_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
plot(x2_Source(((N/2)+1:N),1),x2_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
plot(x3_Source(((N/2)+1:N),1),x3_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
X1xln=[x1((N/2)+1:N,:);x2((N/2)+1:N,:);x3((N/2)+1:N,:)];
%在第二个图中显示
figure(2);
plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
plot(x3_Source((1:N/2),1),x3_Source((1:N/2),2),'ko','MarkerSize',3);hold on;
%---------------------------------------------------------------------------------------------------------
%(b)欧几里得距离
%{
    说明：
    1.由于这个是采用最近邻规则进行判断的所以可以考虑直接对未知数据集同时分类到3个类中而不是像之前的采用两两函数集
    进行求决策面的方式
    2.由于是采用的最近邻规则，所以对于原数据集要进行一定的截取（毕竟不能一开始就已经分好，然后再去分类）
    3.用于作为训练的数据集只取原数据集的1/2
%}
%初始化存储位置
dm_EuclidSource=1:(N/2*3);
%邻域点数
k=11;
%--------------------------------------------
for m=1:length(X1xln)
    X1xlf=[X1xlf(:,1),X1xlf(:,2)];
    %计算距离--采用最原始的方案，计算所有的点与星号位置的距离
    for n=1:(N/2*3)
        %dm_EuclidSource(n)=X1xln(m,:)*S1^(-1)*(X1xlf(n,:))';
        dm_EuclidSource(n)=(X1xln(m,1)-X1xlf(n,1))^2+(X1xln(m,2)-X1xlf(n,2))^2; %计算欧几里得距离
    end
    X1xlf=[X1xlf,dm_EuclidSource'];
    dm_Euclid1=dm_EuclidSource(1:(N/2));
    dm_Euclid2=dm_EuclidSource((N/2+1):(N));
    dm_Euclid3=dm_EuclidSource((N+1):(N*1.5));
    %由于懒的缘故，此处本可以写成for循环但是考虑到就只有3个类，所以懒得写成循环了233333333
    %--------------------------------------------
    %1号类的欧几里得距离
    kRemind=k;
    xRemind=0;%因为不是很好给xRemind定界所以暂时先这样处理--这个可以优化(虽然觉得意义不是很大，毕竟维数不会很高)
    while kRemind>0
        x=find(dm_Euclid1==min(dm_Euclid1));
        xRemind=[xRemind,x];
        kRemind=kRemind-length(x);
        dm_Euclid1(x)=max(dm_Euclid1);
    end
    %此时x标定了满足k=11情况下最远的点
    %GoalxFor1=X1xlf(x(1),1); %最远的点的x值
    %GoalyFor1=X1xlf(x(1),2); %最远的点的y值
    GoalrFor1=X1xlf(x(1),3); %最远的点的半径值
    %--------------------------------------------
    %2号类的欧几里得距离
    kRemind=k;
    xRemind=0;
    while kRemind>0
        x=find(dm_Euclid2==min(dm_Euclid2));
        xRemind=[xRemind,x];
        kRemind=kRemind-length(x);
        dm_Euclid2(x)=max(dm_Euclid2);
    end
    %GoalxFor2=X1xlf(x(1)+N/2,1); %最远的点的x值
    %GoalyFor2=X1xlf(x(1)+N/2,2); %最远的点的y值
    GoalrFor2=X1xlf(x(1)+N/2,3); %最远的点的半径值
    %--------------------------------------------
    %3号类的欧几里得距离
    kRemind=k;
    xRemind=0;
    while kRemind>0
        x=find(dm_Euclid3==min(dm_Euclid3));
        xRemind=[xRemind,x];
        kRemind=kRemind-length(x);
        dm_Euclid3(x)=max(dm_Euclid3);
    end
    %GoalxFor3=X1xlf(x(1)+N,1); %最远的点的x值
    %GoalyFor3=X1xlf(x(1)+N,2); %最远的点的y值
    GoalrFor3=X1xlf(x(1)+N,3); %最远的点的半径值
    %--------------------------------------------
    plot(X1xln(m,1),X1xln(m,2),'go','MarkerSize',5);hold on;
    %--------------------------------------------
    Goalr=[GoalrFor1,GoalrFor2,GoalrFor3];
    Number=find(Goalr==min(Goalr));
    if Number==1
        plot(X1xln(m,1),X1xln(m,2),'r+','MarkerSize',3);hold on;
    elseif Number==2
        plot(X1xln(m,1),X1xln(m,2),'b+','MarkerSize',3);hold on;
    elseif Number==3
        plot(X1xln(m,1),X1xln(m,2),'k+','MarkerSize',3);hold on;
    else
        %这里暂时没有输出信息
    end
    %至此一个点的分类完成
end
%--------------------------------------------
