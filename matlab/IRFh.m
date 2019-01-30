function [y] = IRFh(k)
y = zeros(size(k));
hk=@(k)sin(pi * k / 3) ./ (pi * k);
for i = 1 : length(k)
    y(i) = hk(abs(k(i)));
    if k(i) == 0
        y(i) = 1/3;
    end
end
end


