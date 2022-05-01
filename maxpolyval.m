function [y, t] = maxpolyval(p, t1, t2, eps = 1e-4)
    y = polyval(p, t1);
    t = t1;
    y2 = polyval(p, t2);
    if y2 > y
        y = y2;
        t = t2;
    end
    n = polyorder(p);
    if n == 3
        t3 = -p.c(2)/(2.0*p.c(3));
        if t3 >= t1 && t3 <= t2
            y3 = polyval(p, t3);
            if y3 > y
                y = y3;
                t = t3;
            end
        end
    elseif n == 4
        D = p.c(3)^2 - 3.0*p.c(4)*p.c(2);
        if D >= 0
            for s = [-1, 1]
                t3 = -(p.c(3) + s*sqrt(D))/(3.0*p.c(4));
                if t3 >= t1 && t3 <= t2
                    y3 = polyval(p, t3);
                    if y3 > y
                        y = y3;
                        t = t3;
                    end                    
                end
            end
        end
    end
end
