function y=u_gray(z0)
%����˵��
%----yΪ���������
%----z0Ϊ���������
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
