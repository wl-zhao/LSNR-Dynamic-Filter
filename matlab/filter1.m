function [t_plot, y_t] = filter1(x_t, h_t)
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
n = (length(h_t) - 1) / 2;
y_t = conv(x_t, h_t);
y_t = y_t(n + 1: n + length(x_t));
t_plot = n + 1: length(x_t) - n;
% i=1;
% y=zeros(size(t));
% irfk = irf(-n:n);
% for j=1:length(t)
% yi=zeros(1,2*n+3);
% for k=-n : n
%     yi(i)=irfk(k + n + 1) * x(t(j) - k, R);
%     i=i+1;
% end
% y(j)=sum(yi);
% end
end