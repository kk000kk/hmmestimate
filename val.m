function [ v ] = val( C,P,R,der )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
mid=der/(C*P*C'+R)^0.5;
v=2*mid*gauss(mid)/(Qfunc(-1*mid)-Qfunc(mid));

end