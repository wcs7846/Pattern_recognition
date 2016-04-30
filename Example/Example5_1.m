clc;
clear;
close all;
%�����һ��ʵ�����
%---����㷨�����ݹ�һ���ģ�����ΪһЩ��Ҫ��˵����
%---��Ҫ��������һ�����ݹ�һ����Ч��
%   1.�����ǲ���softmax�������㷨���������ݹ�һ����ʹ֮�������ֵ�͵�λ����
%---------------------------------------------------------------------------------------------------------
%�������ݼ�
m1=[0.4 0.9;
    2.0 1.8;
    2.3 2.3;
    2.6 1.8];
m2=[1.5 1.0;
    1.9 1.0;
    1.5 3.0;
    3.3 2.6];
P1=[1  1];
sita=sqrt(4);
si=[12 0;0 1];
S1=(sita^2)*si;
S2=S1;
N=1000;
x1_Source=mvnrnd(m1(1,:),S1,N);
x2_Source=mvnrnd(m2(1,:),S2,N);
x1=P1(1)*x1_Source;
x2=P1(2)*x2_Source;
figure(1);
%��������ʾ��ѵ������
plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
%plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
X1xlf=[x1(1:(N/2),:);x2(1:(N/2),:)];
%��������ʾ��δѵ������
%plot(x1_Source(((N/2)+1:N),1),x1_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
%plot(x2_Source(((N/2)+1:N),1),x2_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
X1xln=[x1((N/2)+1:N,:);x2((N/2)+1:N,:)];
%�ڵڶ���ͼ����ʾ
%figure(2);
%plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
%plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
%---------------------------------------------------------------------------------------------------------
%�����Ҫ����
xMean=sum(x1(1:length(x1),:))/length(x1);
temp=zeros(1,2);
for n=1:length(x1)
    temp=temp+(x1(n,:)-xMean).^2;
end
xSita=sqrt(temp/(length(x1)-1));
%---------------------------------------------------------------------------------------------------------
%softmax�����任
y=zeros(size(x1));
r=4;
for n=1:length(x1)
    y(n,:)=(x1(n,:)-xMean)./(r*xSita);
end
xNorm=1./(1+exp(-y));
%---------------------------------------------------------------------------------------------------------
plot(y(:,1),y(:,2),'bo','MarkerSize',3);hold on;
figure(2);
plot(y(:,1),y(:,2),'bo','MarkerSize',3);hold on;