clc;
clear;
close all;
%�������ϰ2.2��ʵ������---���ڴ��뱾��Ƚϳ������ֲ������װ�ɺ������Ծ�ֱ��д�������ű�������
%(a)X1���ݼ�������
randn('seed',0);
P1=[1/3,1/3,1/3];
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
plot(x1_Source(:,1),x1_Source(:,2),'ro','MarkerSize',3);hold on;
plot(x2_Source(:,1),x2_Source(:,2),'bo','MarkerSize',3);hold on;
plot(x3_Source(:,1),x3_Source(:,2),'ko','MarkerSize',3);hold on;
X1=[x1;x2;x3];
%---------------------------------------------------------------------------------------------------------
%(b)ŷ����þ���


