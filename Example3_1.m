clc;
clear;
close all;
%�������ϰ3.1��ʵ������
randn('seed',0);
P1=[1  1];
m1=[1  8]';
m2=[14 9]';
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
%---------------------------------------------------------------------------------------------------------
x0=1/N*sum(X1xlf);
plot(x0(1),x0(2),'g+','MarkerSize',7);hold on;
%�ٶ�Ȩ����Ϊ[1 1 b]--bΪ����x0�������ֵ
b=0;%����ǳ�ʼֵ
w0=[1 1 b];
b=-w0(1)*x0(1)-w0(2)*x0(2);
w0=[1 1 b];
%---------------------------------------------------------------------------------------------------------
%����Ȩ����
n1=X1xlf(:,1)';
n2=-5:(25/(length(n1)-1)):20;
for n=1:1:length(n1)
    n2(n)=(-w0(1)*n1(n)-w0(3))/w0(2);
end
plot(n1,n2,'g.','MarkerSize',3);hold on;
%---------------------------------------------------------------------------------------------------------
%�ж�Ȩ�����Ƿ�Ϊ��ȷ����
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
%����һ�³��������
Wx1=ones(length(FalseX1)-1,3);
for n=1:length(FalseX1)-1
    Wx1(n,1:2)=X1xlf(FalseX1(n+1),:);
end
Wx2=ones(length(FalseX2)-1,3);
for n=1:length(FalseX2)-1
    Wx2(n,1:2)=X1xlf(FalseX2(n+1),:);
end
%---------------------------------------------------------------------------------------------------------
%��֪���㷨
Ro=0.7;
Rot=Ro;
wNext=w0'-Ro*(-1)*(Wx1(1,:)'+Wx1(2,:)'+Wx1(3,:)'+Wx1(4,:)')-Ro*(+1)*(Wx2(1,:)'+Wx2(2,:)'+Wx2(3,:)');
%���»�һ��ֱ��
for n=1:1:length(n1)
    n2(n)=(-wNext(1)*n1(n)-wNext(3))/wNext(2);
end
plot(n1,n2,'m.','MarkerSize',3);hold on;