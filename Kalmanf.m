function [ x ] = Kalmanf( A,B,C,Q,R,y,u,sign,der)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
[~,N]=size(y);
x=zeros(2,N);
P=0;
K=0;
for i=2:N
    x(:,i)=A*x(:,i-1)+B*u(:,i-1);
    P=A*P*A'+Q;
    x(:,i)=x(:,i)+sign(i)*K*(y(i)-C*x(:,i));
    K=P*C'*(C*P*C'+R)^-1;
    mid2=val(C,P,R,der);
    mid1=eye(size(mid2));
    P=(mid1-mid2)*P;
end

end

