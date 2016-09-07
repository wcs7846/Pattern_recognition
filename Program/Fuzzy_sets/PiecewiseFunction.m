function y=PiecewiseFunction(x,parameter,point)
%输入参数说明：
%{
    x:
        1.需要计算的输入值(现阶段只支持一个数)
    parameter：
        1.是分段函数的参数值,
        2.为一个(n+1)*2矩阵，每一行代表一段函数的参数,格式为:[k1,b1]
    point:(此处是要利用点的横坐标)
        1.为一个n*2的矩阵，每一行代表一个点的位置参数，格式为：(x,y)
        2.n表示的是节点的个数（可以为2或3）
%}
%输出参数说明：
%{
    y:利用分段函数进行计算的函数值
%}
flag=0;%一个标记
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