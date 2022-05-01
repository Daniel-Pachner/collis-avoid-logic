function [t, y] = pwpdomain(p, k)
    e = 1e-4;
    m = numel(p);
    if m > 0
        dt = (p(m).t2 - p(1).t1 - e)/max(k - m + 1, 1);
        n = zeros(1, m);
        for i = 1 : m
            n(i) = max(fix((p(i).t2 - p(i).t1)/dt) + 1, 2);
        end
        t = zeros(1, sum(n));
        y = zeros(1, sum(n));
        h = 0;
        for i = 1 : m
            idx = h + (1 : n(i));
            t(idx) = linspace(p(i).t1, p(i).t2 - e, n(i));
            y(idx) = pwpevaln(p, t(idx));
            h = h + n(i);
        end
    else
        t = zeros(1, 0);
        y = zeros(1, 0);
    end
end
