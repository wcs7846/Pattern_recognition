clc;
clear;
close all;
%�������ϰ3.5��ʵ������
%------ ����㷨��SVM�������㷨������ΪһЩ��Ҫ��˵����
%       1.���ò���Ǳ���Ҫʹ�ö��ι滮�ĺ����ģ���Ȼ����û�а취��--���ǲ���
%---------------------------------------------------------------------------------------------------------
%{
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
%�ڵڶ���ͼ����ʾ
figure(2);
plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
plot(x1_Source(((N/2)+1:N),1),x1_Source(((N/2)+1:N),2),'go','MarkerSize',5);hold on;
plot(x2_Source(((N/2)+1:N),1),x2_Source(((N/2)+1:N),2),'go','MarkerSize',5);hold on;
%}
%---------------------------------------------------------------------------------------------------------
x1=[ 1  1;
     1 -1];
x2=[-1  1;
    -1 -1];
%---------------------------------------------------------------------------------------------------------
%������ı��ʽΪ��w1*x1+w2*x2+w0=0(����w1��w2����ϵ��)

