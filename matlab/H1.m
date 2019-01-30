function [s] =H1(omega, n, d, alpha, omega_s)
% calculate the frf of LPF
% n: number of terms
% d: delta = 10^(-d)
s = zeros(size(omega));
a = cos(alpha);
delta = 10 ^(-d);
for i = 1 : length(omega)
    if omega(i) <= alpha
        phi = (2 * cos(omega(i)) - a + 1) / (a + 1);
        s(i) = delta * cos(n * acos(phi));
    else
        phi = (2 * cos(omega(i)) -a + 1)/ (a + 1);
        s(i) = (delta/2) * ((phi + sqrt(phi^2 - 1))^n + (phi - sqrt(phi^2-1))^n);
    end
end
phi = (2 * cos(omega_s)- a + 1)/(a + 1);
adj1 = (10^(-d)/2) * ((phi + sqrt(phi^2 - 1))^n + (phi-sqrt(phi^2 - 1))^n);
s = s / adj1;
end

