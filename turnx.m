function [ k ] = turnx( x,x1,x2,tol )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[x1_min,~]=min(x(1,:));
[x2_min,~]=min(x(2,:));
[x1_max,~]=max(x(1,:));
[x2_max,~]=max(x(2,:));
x1_value=x1_min:(x1_max-x1_min)/2^tol:x1_max;
x2_value=x2_min:(x2_max-x2_min)/2^tol:x2_max;
x1_vnum=size(x1_value);
x1_vnum=x1_vnum(2);
x2_vnum=size(x2_value);
x2_vnum=x2_vnum(2);
% global x1_value x2_value x1_vnum x2_vnum;
[~,k_x1]=min((x1_value-x1).^2);
[~,k_x2]=min((x2_value-x2).^2);
k=x1_vnum*(k_x2-1)+k_x1;

end

