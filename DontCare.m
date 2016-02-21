clc
close all
clear
%------------------------------------------------------------------------------------------
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
%这里是显示的训练数据
plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
X1xlf=[x1(1:(N/2),:);x2(1:(N/2),:)];
%这里是显示的未训练数据
plot(x1_Source(((N/2)+1:N),1),x1_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
plot(x2_Source(((N/2)+1:N),1),x2_Source(((N/2)+1:N),2),'mo','MarkerSize',3);hold on;
X1xln=[x1((N/2)+1:N,:);x2((N/2)+1:N,:)];
%在第二个图中显示
figure(2);
plot(x1_Source((1:N/2),1),x1_Source((1:N/2),2),'ro','MarkerSize',3);hold on;
plot(x2_Source((1:N/2),1),x2_Source((1:N/2),2),'bo','MarkerSize',3);hold on;
%---------------------------------------------------------------------------------------------------------
%w1=[0.1 6.8 -3.5 2.0 4.1 3.1 -0.8 0.9 5.0 3.9; 1.1 7.1 -4.1 2.7 2.8 5.0 -1.3 1.2 6.4 4.0]; 
%w2=[7.1 -1.4 4.5 6.3 4.2 1.4 2.4 2.5 8.4 4.1;4.2 -4.3 0.0 1.6 1.9 -3.2 -4.0 -6.1 3.7 -2.2]; 
%normalized 
x1=x1';
x2=x2';
ww1=[ones(1,size(x1,2)); x1]; 
ww2=[ones(1,size(x2,2)); x2]; 
X=[ww1 -ww2];
%initializtion of W&k
k=1;
W=ones(size(X,1),1);
ok=0;
%循环体设计
while(ok==0)
        for i=1:size(X,2)
        if (W'*X(:,i)<0) 
            k=k+1;
            W=W+X(:,i);
            break;
        else
            if (i==size(X,2)) ok=1;
            end
        end
    end
end
%图示
xmin=min(min(x1(1,:)),min(x2(1,:))); 
xmax=max(max(x1(1,:)),max(x2(1,:))); 
ymin=min(min(x1(2,:)),min(x2(2,:))); 
ymax=max(max(x1(2,:)),max(x2(2,:))); 
xindex=xmin-1:(xmax-xmin)/100:xmax+1; 
yindex=-W(2)*xindex/W(3)-W(1)/W(3); 
figure(1);plot(xindex,yindex)%分类面