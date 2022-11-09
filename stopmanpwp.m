function pr = stopmanpwp(t, v0, a0, jM, aM, D)
    if numel(t) ~= 5
        error('stopmanpwp: incorrect time vector, 5 values expected');
    end
    j = [0.0, jM,  0.0, -jM,   0.0];
    a = [a0,  0.0, 0.0,  0.0,  0.0];
    v = [v0,  0.0, 0.0,  0.0,  0.0];
    s = [0.0, 0.0, 0.0,  0.0,  0.0];
    n = length(j);
    for i = 1 : (n-1)
        a(i+1) = polyval(polynomial([a(i), j(i)]), t(i));
        v(i+1) = polyval(polynomial([v(i), a(i), j(i)/2.0]), t(i));
        s(i+1) = polyval(polynomial([s(i), v(i), a(i)/2.0, j(i)/6.0]), t(i));
        if v(i+1) <= 0.01
            a(i+1) = 0;
            v(i+1) = 0;
            j(i+1) = 0;
        end
        
    end
    c = zeros(n, 4);
    for k = 1 : n
        if D == 0
            c(k, :) = [s(k), v(k), a(k)/2.0, j(k)/6.0];
        elseif D == 1
            c(k, :) = [v(k), a(k), j(k)/2.0, 0];
        elseif D == 2
            c(k, :) = [a(k), j(k), 0, 0];
        elseif D == 3
            c(k, :) = [j(k), 0, 0, 0];
        end
    end
    sumt = cumsum([0, t]);    
    p = polynomial(c);
    pr = pwp(p, sumt, sumt(1:n));
end
