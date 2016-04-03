clc;
clear;
close all;
%---------------------------------------------------------------------------------------------------------
%����˵����
%   ---���������ù�����ʵ�ֵ�������ѵ��������ֻ������������ʹ�ã������Ƽ���Ϊԭ��ѧϰʹ��
%   ---ʵ�ֵ�������ѵ��Ϊ��
%   ---1.��׼���ݶ��½�BP�㷨(����ʵ�ֵľ������)
%   ---2.����BP�㷨
%   ---3.����Ӧѧϰ�ʵ�BP�㷨
%---------------------------------------------------------------------------------------------------------
%�������ݼ�
randn('seed',0);
P1=[1  1  1  1];
m1=[1 10]';
m2=[10 1]';
m3=[10,10]';
%m4=[1, 1]';
sita=sqrt(2);
S1=(sita^2)*eye(2);
S2=S1;
S3=S1;
%S4=S1;
N=1000;
x1_Source=mvnrnd(m1,S1,N);
x2_Source=mvnrnd(m2,S2,N);
x3_Source=mvnrnd(m3,S3,N);
%x4_Source=mvnrnd(m4,S4,N);
x1=P1(1)*x1_Source;
x2=P1(2)*x2_Source;
x3=P1(3)*x3_Source;
%x4=P1(4)*x4_Source;
figure(1);
%��������ʾ��ѵ������
plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
plot(x3_Source((1:N/2),1),x3_Source((1:N/2),2),'ko','MarkerSize',3);hold on;
%plot(x4_Source((1:N/2),1),x4_Source((1:N/2),2),'yo','MarkerSize',3);hold on;
X1xlf=[x1(1:(N/2),:);x2(1:(N/2),:);x3(1:(N/2),:)];
%��������ʾ��δѵ������
plot(x1_Source(((N/2)+1:N),1),x1_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
plot(x2_Source(((N/2)+1:N),1),x2_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
plot(x3_Source(((N/2)+1:N),1),x3_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
%plot(x4_Source(((N/2)+1:N),1),x4_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
X1xln=[x1((N/2)+1:N,:);x2((N/2)+1:N,:);x3(((N/2)+1):N,:)];
%{
     1---1����
    -1---2����
     0---3����
%}
y=[ones(1,N/2),-ones(1,N/2),zeros(1,N/2)];%����ǲ��Լ����������
%�ڵڶ���ͼ����ʾ
figure(2);
plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
plot(x3_Source((1:N/2),1),x3_Source((1:N/2),2),'ko','MarkerSize',3);hold on;
%plot(x4_Source((1:N/2),1),x4_Source((1:N/2),2),'yo','MarkerSize',3);hold on;
plot(x1_Source(((N/2)+1:N),1),x1_Source(((N/2)+1:N),2),'go','MarkerSize',3);hold on;
plot(x2_Source(((N/2)+1:N),1),x2_Source(((N/2)+1:N),2),'go','MarkerSize',3);hold on;
plot(x3_Source(((N/2)+1:N),1),x3_Source(((N/2)+1:N),2),'go','MarkerSize',3);hold on;
%plot(x4_Source(((N/2)+1:N),1),x4_Source(((N/2)+1:N),2),'go','MarkerSize',3);hold on;
%---------------------------------------------------------------------------------------------------------
%����ʵ�ֵĹ�������:
%����
methods_list={'traingd';'traingdm';'traingda'};
limit=[min(X1xlf)',max(X1xlf)'];
%���綨��
net=newff(limit,[2 1],{'tansig','tansig'},...
    methods_list{1});
%�����ʼ��
net=init(net);
%��������
net.trainParam.epochs=1000;
net.trainParam.lr=0.5;
net.trainParam.lr_mc=0;
net.trainParam.lr_inc=0;
net.trainParam.max_perf_inc=0;
%����ѵ�� 
net=train(net,X1xlf',y);
%�������
yT=sim(net,X1xln');
TestResult=yT;
yT=round(TestResult);
%---------------------------------------------------------------------------------------------------------
%�������������з���
%���
for n=1:length(yT)
    if yT(1,n)==1
        plot(X1xln(n,1),X1xln(n,2),'ro','MarkerSize',3);hold on;
    elseif yT(1,n)==-1
        plot(X1xln(n,1),X1xln(n,2),'bo','MarkerSize',3);hold on;
    elseif yT(1,n)==0
        plot(X1xln(n,1),X1xln(n,2),'ko','MarkerSize',3);hold on;
    end
end
%---------------------------------------------------------------------------------------------------------
%�����������--��������
Ne=0;
for n=1:length(X1xln)
    if yT(n)~=y(n)
        Ne=Ne+1;
    end
end
Re=Ne/length(X1xln);