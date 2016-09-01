function y=u_gray(z0)
%函数说明
%----y为隶属度输出
%----z0为输入的像素
if z0<=4
    y=0;
elseif z0<=34
    y=(1/30)*z0-(4/30);
elseif z0<=(34+30)
    y=-(1/30)*z0+(34+30)/30;
else
    y=0;
end

end
