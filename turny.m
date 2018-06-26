function [ k ] = turny( y,yk,tol )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
% global y_value
y_min=min(y);
y_max=max(y);
y_value=y_min:(y_max-y_min)/2^tol:y_max;
[~,k]=min((y_value-yk).^2);
end

