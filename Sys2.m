function [ x,y ] = Sys3(x1,x2,N)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明

x=zeros(2,N);
y=zeros(1,N);
x(1,1)=x1;
x(2,1)=x2;
for i=2:N
    x(1,i)=x(1,i-1)*0.9+randn(1,1);
    x(2,i)=x(2,i-1)*-0.8+randn(1,1);
end
y=x(1,:)*0.9+x(2,:)*0.3+randn(1,1)*0.1;
end

