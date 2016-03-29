clc;
clear;
close all;
%---------------------------------------------------------------------------------------------------------
%����˵����
%   ---���������ù�����ʵ�ֵ�������ѵ��������ֻ������������ʹ�ã������Ƽ���Ϊԭ��ѧϰʹ��
%   ---ʵ�ֵ�������ѵ��Ϊ��
%   ---1.��׼���ݶ��½�BP�㷨
%   ---2.����BP�㷨
%   ---3.����Ӧѧϰ�ʵ�BP�㷨
%---------------------------------------------------------------------------------------------------------
%�������ݼ�
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
%��������ʾ��ѵ������
plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
X1xlf=[x1(1:(N/2),:);x2(1:(N/2),:)];
%��������ʾ��δѵ������
plot(x1_Source(((N/2)+1:N),1),x1_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
plot(x2_Source(((N/2)+1:N),1),x2_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
X1xln=[x1((N/2)+1:N,:);x2((N/2)+1:N,:)];
%
y=[ones(1,N/2),-ones(1,N/2)];
yF=[ones(1,N/2),-ones(1,N/2)];%����ǲ��Լ����������
%�ڵڶ���ͼ����ʾ
figure(2);
plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
plot(x1_Source(((N/2)+1:N),1),x1_Source(((N/2)+1:N),2),'go','MarkerSize',5);hold on;
plot(x2_Source(((N/2)+1:N),1),x2_Source(((N/2)+1:N),2),'go','MarkerSize',5);hold on;
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
net.trainParam.epochs=10000;
net.trainParam.lr=0.5;
net.trainParam.lr_mc=0;
net.trainParam.lr_inc=0;
net.trainParam.max_perf_inc=0;
%����ѵ�� 
net=train(net,X1xlf',y);
%�������
yT=sim(net,X1xln');
%---------------------------------------------------------------------------------------------------------
%�������������з���
local=find(yT>0);
Fx1=X1xln(local,:);
yT(local)=1;
local=find(yT<=0);
Fx2=X1xln(local,:);
yT(local)=-1;
%���
plot(Fx1(:,1),Fx1(:,2),'ro','MarkerSize',5);hold on;
plot(Fx2(:,1),Fx2(:,2),'bo','MarkerSize',5);hold on;
%---------------------------------------------------------------------------------------------------------
%�����������--��������
e=yF-yT;
local=find(e>0);
Re=length(local)/N;