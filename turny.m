function [ k ] = turny( y,yk,tol )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% global y_value
y_min=min(y);
y_max=max(y);
y_value=y_min:(y_max-y_min)/2^tol:y_max;
[~,k]=min((y_value-yk).^2);
end

