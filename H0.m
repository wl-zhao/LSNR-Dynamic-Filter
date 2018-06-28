function [s] = H0(omega, type)
% calculate the frequency response
% type decide which H to calculate 

if type == 0
    n = 64;
    s = 0;
    for k = -n : n
        s = s + IRFh(k) .* cos(k * omega);
    end
end

if type == 1
    ct=size(omega);
    s=zeros(1,ct(2));
    n=30;
    d=13;
    alpha=3*pi/8;
    a=cos(alpha);
    beta=5*pi/24;
    b=cos(pi/2-beta);
    for i=1:ct(2)
        if omega(i)>alpha
            phi=(2*cos(omega(i))-a+1)/(a+1);
            s(i)=10^(-d)*cos(n*acos(phi));
        else
            if omega(i)<=alpha&&omega(i)>=pi/4
                phi=(2*cos(omega(i))-a+1)/(a+1);
                s(i)=(10^(-d)/2)*((phi+sqrt(phi^2-1))^n+(phi-sqrt(phi^2-1))^n);
            else
                if omega(i)<=pi/4&&omega(i)>beta
                    temp=pi/2-omega(i);
                    phi=(2*cos(temp)-b+1)/(b+1);
                    s(i)=(10^(-d)/2)*((phi+sqrt(phi^2-1))^n+(phi-sqrt(phi^2-1))^n);
                else
                    if omega(i)<=beta
                        temp=pi/2-omega(i);
                       phi=(2*cos(temp)-b+1)/(b+1);
                        s(i)=10^(-d)*cos(n*acos(phi));
                    end
                end
            end
        end
    end
    phi=(2*cos(pi/4)-a+1)/(a+1);
    adj1=(10^(-d)/2)*((phi+sqrt(phi^2-1))^n+(phi-sqrt(phi^2-1))^n);
    phi=(2*cos(pi/4)-b+1)/(b+1);
    adj2=(10^(-d)/2)*((phi+sqrt(phi^2-1))^n+(phi-sqrt(phi^2-1))^n);
    for i=1:ct(2)
        if omega(i)>pi/4;
            s(i)=s(i)/adj1;
        else
            if omega(i)<pi/4
                s(i)=s(i)/adj2;
            else
                s(i)=1;
            end
        end
    end
    s=s/(2*pi);
end
end

