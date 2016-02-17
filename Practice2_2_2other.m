clc;
clear;
close all;
%�������ϰ2.2��ʵ������---���ڴ��뱾��Ƚϳ������ֲ������װ�ɺ������Ծ�ֱ��д�������ű�������
%(a)X1���ݼ�������
randn('seed',0);
P1=[1,1,1];%���ﱾ��Ӧ����1/3�ģ����ǿ��ǵ�Ϊ�������������1����--�ü���
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
%��������ʾ��ѵ������
plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
plot(x3_Source((1:N/2),1),x3_Source((1:N/2),2),'ko','MarkerSize',3);hold on;
X1xlf=[x1(1:(N/2),:);x2(1:(N/2),:);x3(1:(N/2),:)];
%��������ʾ��δѵ������
plot(x1_Source(((N/2)+1:N),1),x1_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
plot(x2_Source(((N/2)+1:N),1),x2_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
plot(x3_Source(((N/2)+1:N),1),x3_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
X1xln=[x1((N/2)+1:N,:);x2((N/2)+1:N,:);x3((N/2)+1:N,:)];
%---------------------------------------------------------------------------------------------------------
%(b)ŷ����þ���
%{
    ˵����
    1.��������ǲ�������ڹ�������жϵ����Կ��Կ���ֱ�Ӷ�δ֪���ݼ�ͬʱ���ൽ3�����ж�������֮ǰ�Ĳ�������������
    �����������ķ�ʽ
    2.�����ǲ��õ�����ڹ������Զ���ԭ���ݼ�Ҫ����һ���Ľ�ȡ���Ͼ�����һ��ʼ���Ѿ��ֺã�Ȼ����ȥ���ࣩ
    3.������Ϊѵ�������ݼ�ֻȡԭ���ݼ���1/2
    4.���㷨���ھ����㷨�����ϸĽ����㷨--�����Լ��ĵģ���ʱû�������ϵĻ���23333��
%}
%��ʼ���洢λ��
dm_Euclid=1:(N/2*3);
%�������
k=11;
%�������--������ԭʼ�ķ������������еĵ����Ǻ�λ�õľ���
for n=1:(N/2*3)
    dm_Euclid(n)=(X1xln(1,1)-X1xlf(n,1))^2+(X1xln(1,2)-X1xlf(n,2))^2; %����ŷ����þ���
end
X1xlf=[X1xlf,dm_Euclid'];
kRemind=k;
xRemind=0;%��Ϊ���Ǻܺø�xRemind����������ʱ����������--��������Ż�(��Ȼ�������岻�Ǻܴ󣬱Ͼ�ά������ܸ�)
while kRemind>0
    x=find(dm_Euclid==min(dm_Euclid));
    xRemind=[xRemind,x];
    kRemind=kRemind-length(x);
    dm_Euclid(x)=max(dm_Euclid);
end
%��ʱx�궨������k=11�������Զ�ĵ�
GoalxFor1=X1xlf(x(1),1); %��Զ�ĵ��xֵ
GoalyFor1=X1xlf(x(1),2); %��Զ�ĵ��yֵ
GoalrFor1=X1xlf(x(1),3); %��Զ�ĵ�İ뾶ֵ
%{
plot(X1xln(1,1),X1xln(1,2),'go','MarkerSize',5);hold on;
plot([X1xln(1,1)-sqrt(GoalrFor1),X1xln(1,1)+sqrt(GoalrFor1)],[X1xln(1,2),X1xln(1,2)],'g-');hold on;
plot([X1xln(1,1),X1xln(1,1)],[X1xln(1,2)-sqrt(GoalrFor1),X1xln(1,2)+sqrt(GoalrFor1)],'g-');hold on;
%��ԲȦ
rd=pi/180;
for n=1:1:360
    CircleX=X1xln(1,1)+sqrt(GoalrFor1)*cos(n*rd);
    CircleY=X1xln(1,2)+sqrt(GoalrFor1)*sin(n*rd);
    plot(CircleX,CircleY,'g.','MarkerSize',0.5);hold on;
end
%}
%ԲȦ�ڵ�ѵ����
NeedClassify=xRemind(2:length(xRemind));
%{
for n=1:length(NeedClassify)
    plot(X1xlf(NeedClassify(n),1),X1xlf(NeedClassify(n),2),'g*','MarkerSize',3);hold on;
end
%}
%����ԲȦ�ڵ�ѵ�����ڸ�����ķֲ����
