function [ y ] = Qfunc(x )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
f = @(t) 1/(2*pi)^0.5*exp(-0.5*t.^2);
y = integral(@(t)f(t),x,inf);
end

