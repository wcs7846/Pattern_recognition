function parameter=Membership_Degree_Parameter(point)
%�������˵����
%{
    pointΪһ��n*2�ľ���ÿһ�д���һ�����λ�ò�������ʽΪ��(x,y)
    n��ʾ���ǽڵ�ĸ���������Ϊ2��3��
    2����ֱ��������Ⱥ�����2��ת�۴����������£�
    ��
    ح        A  
    ح����������  
    ح          \
    ح           \
    ح            \ B
    ʮ����������������������������������
    ��Ҫ�����ã�Ϊ���������Ⱥ�����б�ʺͽؾ����
%}
%�������˵����
%{
    parameterΪһ��n*2����ÿһ�д���һ�κ����Ĳ���,��ʽΪ:[k1,b1]������n��ʾ�м���
    �����Ⱥ������÷ֶκ������Һ�������ʽ���ã�y=kx+b����ʽ������k��bΪ����
%}
%��ʼ��
[row,col]=size(point);
if col~=2
    errordlg('Please check the format of the input point!','Input Error');
end
parameter=zeros(row+1,2);
%---------------------------------------------------------------------------
%������Ӧ�Ĳ���
parameter(1,2)=point(1,2);
parameter(row+1,2)=point(row,2);
%��row==1��ʱ����ʵ�ǲ�������Ĵ���
if row ~= 1
    for n=2:row
        parameter(n,1)=(point(n,2)-point(n-1,2))/(point(n,1)-point(n-1,1));
        parameter(n,2)=point(n,2)-parameter(n,1)*point(n,1);
    end   
end
end