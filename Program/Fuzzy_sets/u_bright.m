function y=u_bright(z0)
%函数说明
%----y为隶属度输出
%----z0为输入的像素
if z0<=34
    y=0;
elseif z0>=34+30
    y=1;
else
    y=(1/30)*z0-(34/30);
end
end
