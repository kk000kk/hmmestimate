function [ x1,x2 ] = deturnx( x,k,tol )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
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
x1=mod(k,x1_vnum);
x2=(k-x1)/x1_vnum+1;
x1=x1_value(x1);
x2=x2_value(x2);
end

