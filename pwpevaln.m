function y = pwpevaln(p, t)
    n = length(t);
    y = zeros(1, n);
    for i = 1 : n
        y(i) = pwpeval(p, t(i));
    end
end

