function y=u_bright(z0)
%����˵��
%----yΪ���������
%----z0Ϊ���������
if z0<=34
    y=0;
elseif z0>=34+30
    y=1;
else
    y=(1/30)*z0-(34/30);
end
end
