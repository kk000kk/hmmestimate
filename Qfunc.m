function [ y ] = Qfunc(x )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
f = @(t) 1/(2*pi)^0.5*exp(-0.5*t.^2);
y = integral(@(t)f(t),x,inf);
end

