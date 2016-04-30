clc;
clear;
close all;
%�������ϰ3.5��ʵ������
%------ ����㷨��BP�������㷨������ΪһЩ��Ҫ��˵����
%---------------------------------------------------------------------------------------------------------
%�������ݼ�
%   ---���ݼ��ļ�Ҫ˵����
%   ---1.���ݼ�������ֻ��һ���򵥵ĸ�˹�ֲ��ĵ㣬���ñ���ǰ����
%   ---2.���ݼ������ݲ��������Կɷֵģ���Ȼ�Ƿ����Եģ�����֮ǰ�����Է���������ֱ��ʹ����
%   ---3.���ݼ��ܹ�����1000���㣬����ֻ��2����
%   ---4.Ϊ����ʾ�������㣬��������ÿ��������ά��Ϊ2.��Ϊ2ά�ȽϺû�ͼ
randn('seed',0);
P1=[1  1];
m1=[0.4 0.9;
    2.0 1.8;
    2.3 2.3;
    2.6 1.8];
m2=[1.5 1.0;
    1.9 1.0;
    1.5 3.0;
    3.3 2.6];
sita=sqrt(0.01);
S1=(sita^2)*eye(2);
S2=S1;
N=400;
%�������λ��
x1_Source=zeros(N,2);
x2_Source=zeros(N,2);
X1xlf=zeros(N,2);
X1xln=zeros(N,2);
%������ʱλ��
x1_Stemp=zeros(floor(N/length(m1)),2);
x2_Stemp=zeros(floor(N/length(m2)),2);
%����������---�˴��Ǽٶ�m1==m2�ˣ������һ����Ҫ�ֿ���
for n=1:length(m1)
    x1_Stemp=mvnrnd(m1(n,:),S1,floor(N/length(m1)));
    x2_Stemp=mvnrnd(m2(n,:),S2,floor(N/length(m2)));
    x1_Source((n-1)*floor(N/length(m1))+1:n*floor(N/length(m1)),:)=x1_Stemp;
    x2_Source((n-1)*floor(N/length(m2))+1:n*floor(N/length(m2)),:)=x2_Stemp;
    X1xlf((n-1)*floor(N/length(m1))/2+1:n*floor(N/length(m1))/2,:)=x1_Stemp(1:(floor(N/length(m1)))/2,:);
    X1xlf((n-1)*floor(N/length(m2))/2+1+N/2:n*floor(N/length(m2))/2+N/2,:)=x2_Stemp(1:(floor(N/length(m2)))/2,:);
    X1xln((n-1)*floor(N/length(m1))/2+1:n*floor(N/length(m1))/2,:)=x1_Stemp((floor(N/length(m1)))/2+1:floor(N/length(m1)),:);
    X1xln((n-1)*floor(N/length(m2))/2+1+N/2:n*floor(N/length(m2))/2+N/2,:)=x2_Stemp((floor(N/length(m2)))/2+1:floor(N/length(m2)),:);
end
x1=P1(1)*x1_Source;
x2=P1(2)*x2_Source;
figure(1);
%��������ʾ��ѵ������
plot(X1xlf(1:(length(X1xlf))/2,1),X1xlf(1:(length(X1xlf))/2,2),'ro','MarkerSize',3);hold on;
plot(X1xlf((length(X1xlf))/2+1:length(X1xlf),1),X1xlf((length(X1xlf))/2+1:length(X1xlf),2),'bo','MarkerSize',3);hold on;
%��������ʾ��δѵ������
plot(X1xln(1:(length(X1xlf))/2,1),X1xln(1:(length(X1xlf))/2,2),'mo','MarkerSize',3);hold on;
plot(X1xln((length(X1xlf))/2+1:length(X1xlf),1),X1xln((length(X1xlf))/2+1:length(X1xlf),2),'mo','MarkerSize',3);hold on;
%---------------------------------------------------------------------------------------------------------
%������Ľṹ˵����
%   ---1.�ɡ��������-������-����㡱�Ľṹ
%   ---2.����������Ϊ1�������������Ϊ1������������Ϊ1
%   ---3.���÷��򴫲����㷨�����Ƿ���������
%   ---4.������ʼ�İ汾������û�мӶ�������ؼ��ģ����Կ���������ָ����ľֲ���С
%ʹ�õı���˵����
%   ---1.����������x
%   ---2.���������y
%   ---3.ʵ�������O
%   ---4.���������d
%   ---5.Ȩֵ������V
%                 W
%-------------------
%Ȩֵ��ʼ��---ʹ�þ�ֵ�ֲ���[0,1]����
innum = 2;  %
midnum = 2; %
outnum = 2; %
alefa = 1;  %������еĲ���
xierta=0.1;
%��������---��MATLAB�����еĿ��ܲ���Ҫ
d=[ones(length(X1xlf)/2,1) ,zeros(length(X1xlf)/2,1) ;
   zeros(length(X1xlf)/2,1),ones(length(X1xlf)/2,1) ];
J=0;%����Ǵ��ۺ���
%y=rand(midnum,1);
%o=rand(outnum,1);
%�����ֵ
w1=rand(innum,midnum);
bw1=rand(midnum,1); %�������ֵ���������������Ļ�����Ҫ��չy��ֵ
v1=rand(midnum,outnum);
bv1=rand(outnum,1); %ͬ��Ϊ��ֵ
%-----ǰ�����--------
%�������
ytemp=X1xlf(1,:)*w1+bw1';
y=1./(1+exp(-alefa*ytemp'));%ע��������Ҫ./��Ϊ�����е�����Ҫȡ����---ͬʱ�˴����Ǽ����
%��������
o=(y')*v1+bv1';
%o=1./(1+exp(-alefa*otemp'));%ע��ͬ����Ҫ����
%������
e=d(1,:)-o;
J=J+sum(e);
%-----�������--------
%����Ȩֵ�仯ֵ
dv1=e'.*y;%�����ʱû��Ū����һ��������һ������������ΪӦ����һ������ 
dbv1=e;

fx=alefa*(y.*(1-y));

%dw1=fx*X1xlf(1,:)
%dbw1=