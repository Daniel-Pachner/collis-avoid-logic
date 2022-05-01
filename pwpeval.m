function y = pwpeval(p, t)
    n = length(p);
    y = NaN;
    t1 = p(1).t1;
    for i = 1 : n
        if t >= t1 && t <= p(i).t2
            y = polyval(p(i), t - p(i).t0);
        end
        t1 = p(i).t2;
    end
end

