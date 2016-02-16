clc;
clear;
close all;
%这个是练习2.2的实例程序
%(a)X1数据集的生成
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
%(b)--贝叶斯分类--此部分的代码完成并且完成测试
%说明由于贝叶斯分类其是生成的线性函数作为决策面，所以只能两两函数即来计算决策面--同时使在有相同元素的对角线协方差矩阵
%x1-x2
X12=[x1;x2];
x12_1=X12(:,1);
x12_2=X12(:,2);
S12=S1;
w12=(m1-m2);
Fan_12=(m1-m2)'*(m1-m2);%表示范数
x0_12=1/2*(m1+m2)-(sita^2)*log(P1(1)/P1(2))*((m1-m2)/(Fan_12));
plot(x0_12(1),x0_12(2),'r+');hold on;
%注：这里需要自己手动解一下矩阵方程
x12_T1=-w12(2)*(x12_2-x0_12(2))/(w12(1))+x0_12(1);
plot(x12_T1,x12_2,'r.');hold on;
x12_T2=-w12(1)*(x12_1-x0_12(1))/(w12(2))+x0_12(2);
plot(x12_1,x12_T2,'r.');hold on;
%x1-x3
X13=[x1;x3];
x13_1=X13(:,1);
x13_2=X13(:,2);
S13=S1;
w13=(m1-m3);
Fan_13=(m1-m3)'*(m1-m3);%表示范数
x0_13=1/2*(m1+m3)-(sita^2)*log(P1(1)/P1(3))*((m1-m3)/(Fan_13));
plot(x0_13(1),x0_13(2),'r+');hold on;
%注：这里需要自己手动解一下矩阵方程
x13_T1=-w13(2)*(x13_2-x0_13(2))/(w13(1))+x0_13(1);
plot(x13_T1,x13_2,'r.');hold on;
x13_T2=-w13(1)*(x13_1-x0_13(1))/(w13(2))+x0_13(2);
plot(x13_1,x13_T2,'r.');hold on;
%x2-x3
X23=[x2;x3];
x23_1=X23(:,1);
x23_2=X23(:,2);
S23=S2;
w23=(m2-m3);
Fan_23=(m2-m3)'*(m2-m3);%表示范数
x0_23=1/2*(m2+m3)-(sita^2)*log(P1(2)/P1(3))*((m2-m3)/(Fan_23));
plot(x0_23(1),x0_23(2),'r+');hold on;
%注：这里需要自己手动解一下矩阵方程
x23_T1=-w23(2)*(x23_2-x0_23(2))/(w23(1))+x0_23(1);
plot(x23_T1,x23_2,'r.');hold on;
x23_T2=-w23(1)*(x23_1-x0_23(1))/(w23(2))+x0_23(2);
plot(x23_1,x23_T2,'r.');hold on;
%---------------------------------------------------------------------------------------------------------
%(b)欧几里得距离

%---------------------------------------------------------------------------------------------------------
%(b)Mahalanobis距离