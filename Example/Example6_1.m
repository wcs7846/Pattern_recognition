clc;
clear;
close all;
%这个是一个例子6.1的程序
%---这个算法是验证变化图像可以通过内积计算出来的
%-----------------
x=[1 2;
   2 3;];
U=[1  1;
   1 -1;];
U=1/(sqrt(2))*U;
%-----------------
%其中Y为变换图像
Y=U'*x*U;
%-----------------
%对应的基本图像为
A00=U(1,:)'*U(1,:);
A11=U(2,:)'*U(2,:);
A10=U(2,:)'*U(1,:);
A01=U(1,:)'*U(2,:);
%-----------------
%现在验证Y元素可通过矩阵内积
%注意此处为点乘
Y1=zeros(2,2);
Y1(1,1)=sum(sum(conj(A00).*x));
Y1(1,2)=sum(sum(conj(A01).*x));
Y1(2,1)=sum(sum(conj(A10).*x));
Y1(2,2)=sum(sum(conj(A11).*x));




