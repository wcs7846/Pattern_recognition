function y=u_dark(z0)
%函数说明
%----y为隶属度输出
%----z0为输入的像素
if z0<=4
    y=1;
elseif z0>=34
    y=0;
else
    y=-(1/30)*z0+(34/30);
end
end
