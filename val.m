function [ v ] = val( C,P,R,der )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
mid=der/(C*P*C'+R)^0.5;
v=2*mid*gauss(mid)/(Qfunc(-1*mid)-Qfunc(mid));

end