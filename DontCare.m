clc
close all
clear
%------------------------------------------------------------------------------------------

%通用径向基函数网络——
%其在逼近能力,分类能力,学习速度方面均优于BP神经网络
%在径向基网络中,径向基层的散步常数是spread的选取是关键
%spread越大,需要的神经元越少,但精度会相应下降,spread的缺省值为1
%可以通过net=newrbe(P,T,spread)生成网络,且误差为0
%可以通过net=newrb(P,T,goal,spread)生成网络,神经元由1开始增加,直到达到训练精度或神经元数目最多为止
%GRNN网络,迅速生成广义回归神经网络(GRNN)
P=[4 5 6];
T=[1.5 3.6 6.7];
net=newgrnn(P,T);
%仿真验证
p=4.5;
v=sim(net,p)
%PNN网络,概率神经网络
P=[0 0 ;1 1;0 3;1 4;3 1;4 1;4 3]';
Tc=[1 1 2 2 3 3 3];
%将期望输出通过ind2vec()转换,并设计、验证网络
T=ind2vec(Tc);
net=newpnn(P,T);
Y=sim(net,P);
Yc=vec2ind(Y)
%尝试用其他的输入向量验证网络
P2=[1 4;0 1;5 2]';
Y=sim(net,P2);
Yc=vec2ind(Y)
%应用newrb()函数构建径向基网络,对一系列数据点进行函数逼近
P=-1:0.1:1;
T=[-0.9602 -0.5770 -0.0729 0.3771 0.6405 0.6600 0.4609...
    0.1336 -0.2013 -0.4344 -0.500 -0.3930 -0.1647 -0.0988...
    0.3072 0.3960 0.3449 0.1816 -0.0312 -0.2189 -0.3201];
%绘制训练用样本的数据点
plot(P,T,'r*');
title('训练样本');
xlabel('输入向量P');
ylabel('目标向量T');
%设计一个径向基函数网络，网络有两层,隐层为径向基神经元,输出层为线性神经元
%绘制隐层神经元径向基传递函数的曲线
p=-3:.1:3;
a=radbas(p);
plot(p,a)
title('径向基传递函数')
xlabel('输入向量p')
%隐层神经元的权值、阈值与径向基函数的位置和宽度有关,只要隐层神经元数目、权值、阈值正确,可逼近任意函数
%例如
a2=radbas(p-1.5);
a3=radbas(p+2);
a4=a+a2*1.5+a3*0.5;
plot(p,a,'b',p,a2,'g',p,a3,'r',p,a4,'m--')
title('径向基传递函数权值之和')
xlabel('输入p');
ylabel('输出a');
%应用newrb()函数构建径向基网络的时候,可以预先设定均方差精度eg以及散布常数sc
eg=0.02;
sc=1;  %其值的选取与最终网络的效果有很大关系,过小造成过适性,过大造成重叠性
net=newrb(P,T,eg,sc);
%网络测试
plot(P,T,'*')
xlabel('输入');
X=-1:.01:1;
Y=sim(net,X);
hold on
plot(X,Y);
hold off
legend('目标','输出')
%应用grnn进行函数逼近
P=[1 2 3 4 5 6 7 8];
T=[0 1 2 3 2 1 2 1];
plot(P,T,'.','markersize',30)
axis([0 9 -1 4])
title('待逼近函数')
xlabel('P')
ylabel('T')
%网络设计
%对于离散数据点,散布常数spread选取比输入向量之间的距离稍小一些
spread=0.7;
net=newgrnn(P,T,spread);
%网络测试
A=sim(net,P);
hold on
outputline=plot(P,A,'o','markersize',10,'color',[1 0 0]);
title('检测网络')
xlabel('P')
ylabel('T和A')
%应用pnn进行变量的分类
P=[1 2;2 2;1 1];    %输入向量
Tc=[1 2 3];          %P对应的三个期望输出
%绘制出输入向量及其相对应的类别
plot(P(1,:),P(2,:),'.','markersize',30)
for i=1:3
    text(P(1,i)+0.1,P(2,i),sprintf('class %g',Tc(i)))
end
axis([0 3 0 3]);
title('三向量及其类别')
xlabel('P(1,:)')
ylabel('P(2,:)')
%网络设计
T=ind2vec(Tc);
spread=1;
net=newgrnn(P,T,speard);
%网络测试
A=sim(net,P);
Ac=vec2ind(A);
  %绘制输入向量及其相应的网络输出
plot(P(1,:),P(2,:),'.','markersize',30)
for i=1:3
    text(P(1,i)+0.1,P(2,i),sprintf('class %g',Ac(i)))
end
axis([0 3 0 3]);
title('网络测试结果')
xlabel('P(1,:)')
ylabel('P(2,:)')