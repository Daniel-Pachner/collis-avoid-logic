function n = polyorder(p, eps = 1e-5)
    n = length(p.c);
    while n > 1 && abs(p.c(n)) <= eps
        n = n - 1;
    end
end
