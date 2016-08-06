clc;
clear;
close all;
%�������ϰ3.1��ʵ������
%------ ����㷨�ǸĽ��ĸ�֪���㷨������ΪһЩ��Ҫ��˵����
%       1.����㷨�ǻ��ڸ�֪���㷨�ģ����Դ󲿷ֶ��Ǹ�֪���㷨������
%       2.���ڵĸĽ������Ǽ����˽����ͳͷ����ƣ��������ǵ������ж��ˡ�
randn('seed',0);
P1=[1  1];
m1=[1 14]';
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
title('ԭʼ����');
%�ڵڶ���ͼ����ʾ
figure(2);
plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
title('����������');
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
%��֪���㷨
%Ȩ��������ʽΪ��ax1+bx2+c=0<---->w=[a,b,c]'
%����ϵ��siertax
ww1=[x1,ones(size(x1,1),1)]; 
ww2=[x2,-ones(size(x2,1),1)]; 
X=[ww1;ww2];
W=w0';
%W=ones(size(X,2),1);
ok=0;
%��ʼ����������
Ro=0.05;
k=1;%��������������Ե�
%ѭ����
while(ok==0)
    for n=1:size(X,1)
        if (W'*X(n,:)'<=0 && X(n,3)==1) 
            k=k+1;
            W=W+Ro*X(n,:)';
            break;
        elseif (W'*X(n,:)'>=0 && X(n,3)==-1) 
            k=k+1;
            W=W-Ro*X(n,:)';
            break;
        else
            if (n==size(X,1)) 
                ok=1;
            end
        end
    end
end
%���»�һ��ֱ��
%n1=X1xlf(:,1)';
n2=-W(1)*n1/W(2)-W(3)/W(2); 
plot(n1,n2,'m.','MarkerSize',3);hold on;
%---------------------------------------------------------------------------------------------------------
%����Ȩ�������з���
nfx1=X1xln(:,1)';
nfx2=X1xln(:,2)';
for n=1:1:length(nfx1)
    if m1(2)>m2(2)
        if nfx2(n)>n2(n)
            plot(nfx1(n),nfx2(n),'r+','MarkerSize',3);hold on;
        else
            plot(nfx1(n),nfx2(n),'b+','MarkerSize',3);hold on;
        end
    else
        if nfx2(n)<n2(n)
            plot(nfx1(n),nfx2(n),'r+','MarkerSize',3);hold on;
        else
            plot(nfx1(n),nfx2(n),'b+','MarkerSize',3);hold on;
        end
    end
end
%---------------------------------------------------------------------------------------------------------

