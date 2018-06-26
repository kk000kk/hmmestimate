function [ x,y,u ] = Sys3(x1,x2,N)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
global A B C L;

x=zeros(2,N);
y=zeros(1,N);
x(1,1)=x1;
x(2,1)=x2;
u=randn(2,N);
y(1)=C*x(:,1)+L*u(:,1);


for i=2:N
x(:,i)=A*x(:,i-1)+B*u(:,i-1)+randn(2,1);
y(i)=C*x(:,i)+L*u(:,i)+0.5*randn(1,1);
end

end

