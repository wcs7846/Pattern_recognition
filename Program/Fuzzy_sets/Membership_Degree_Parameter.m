function parameter=Membership_Degree_Parameter(point)
%输入参数说明：
%{
    point为一个n*2的矩阵，每一行代表一个点的位置参数，格式为：(x,y)
    n表示的是节点的个数（可以为2或3）
    2个点分别在隶属度函数的2个转折处，具体如下：
    ↑
    丨        A  
    丨—————  
    丨          \
    丨           \
    丨            \ B
    十————————————————→
    主要的作用：为计算隶属度函数的斜率和截距参数
%}
%输出参数说明：
%{
    parameter为一个n*2矩阵，每一行代表一段函数的参数,格式为:[k1,b1]，其中n表示有几段
    隶属度函数采用分段函数，且函数的形式采用：y=kx+b的形式，其中k和b为参数
%}
%初始化
[row,col]=size(point);
if col~=2
    errordlg('Please check the format of the input point!','Input Error');
end
parameter=zeros(row+1,2);
%---------------------------------------------------------------------------
%计算相应的参数
parameter(1,2)=point(1,2);
parameter(row+1,2)=point(row,2);
%当row==1的时候其实是不用下面的处理
if row ~= 1
    for n=2:row
        parameter(n,1)=(point(n,2)-point(n-1,2))/(point(n,1)-point(n-1,1));
        parameter(n,2)=point(n,2)-parameter(n,1)*point(n,1);
    end   
end
end