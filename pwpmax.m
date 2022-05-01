function [y, t] = pwpmax(p)
    y = -Inf;
    t = -Inf;
    for i = 1 : numel(p)
        [yn, tn] = maxpolyval(...
        polynomial(p(i).c), p(i).t1 - p(i).t0, p(i).t2 - p(i).t0);
        if yn > y
            y = yn;
            t = tn + p(i).t0;
        end
    end
end
