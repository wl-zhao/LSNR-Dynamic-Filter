function [h_t] = oirf(H, n, d, alpha, omega_s, type)
global int
global lat
% H: frf
% n: number of terms
% d: delta = 10^(-d)
% alpha: cutoff frequency
% omega_s: signal frequecy
% type = 1:lpf, type = 2:hpf
h_t = zeros(1, 2 * n + 1);
if type == 1
    H_1 = @(w)H(w, n, d, alpha, omega_s);
    omega = linspace(0, pi, 1000);
    Hejw = H_1(omega);
    plot(omega, Hejw);
    xlabel('$\omega$', int, lat);
    ylabel('$H_1(e^{\rm{j}\omega})$', int, lat);
    xlim([omega_s, pi]);
    grid on;
    set(gca,'XTick',[pi/4,pi/2, pi]);xticklabels={'\pi/4','\alpha', '\pi'};
    set(gca,'xticklabel',xticklabels);
    for k = -n : n
        f = @(w)H(w, n, d, alpha, omega_s) .* cos(k * w) * 2;
        h_t(k + n + 1) = 1 / (2 * pi) * integral(f, 0, pi);
    end
else
    if type == 2
        H_2 = @(w)H(2 * omega_s - w, n, d, 2 * omega_s - alpha, omega_s);
        omega = linspace(0, pi, 1000);
        Hejw = H_2(omega);
        plot(omega, Hejw);
        xlabel('$\omega$', int, lat);
        ylabel('$H_2(e^{\rm{j}\omega})$', int, lat);
        xlim([0, omega_s]);
        grid on;
        set(gca,'XTick',[0,pi/6, pi/4]);
        xticklabels={'0','\beta', '\pi/4'};
        set(gca,'xticklabel',xticklabels);
        for k = -n : n
            f = @(w)H(2 * omega_s - w, n, d, 2 * omega_s - alpha, omega_s) .* cos(k * w) * 2;
            h_t(k + n + 1) = 1 / (2 * pi) * integral(f, 0, pi);
        end
    end
end
end


