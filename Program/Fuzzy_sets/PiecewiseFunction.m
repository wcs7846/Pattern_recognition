function y=PiecewiseFunction(x,parameter,point)
%�������˵����
%{
    x:
        1.��Ҫ���������ֵ(�ֽ׶�ֻ֧��һ����)
    parameter��
        1.�Ƿֶκ����Ĳ���ֵ,
        2.Ϊһ��(n+1)*2����ÿһ�д���һ�κ����Ĳ���,��ʽΪ:[k1,b1]
    point:(�˴���Ҫ���õ�ĺ�����)
        1.Ϊһ��n*2�ľ���ÿһ�д���һ�����λ�ò�������ʽΪ��(x,y)
        2.n��ʾ���ǽڵ�ĸ���������Ϊ2��3��
%}
%�������˵����
%{
    y:���÷ֶκ������м���ĺ���ֵ
%}
flag=0;%һ�����
[row,~]=size(point);
for n=1:row
    if x<point(n)
        y=parameter(n,1)*x+parameter(n,2);
        flag=1;
        break;
    end
end

if flag==0
   y=parameter(row+1,1)*x+parameter(row+1,2); 
end

end