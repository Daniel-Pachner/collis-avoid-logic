function y = polyval(p, t)
    y = zeros(size(t));
    for i = length(p.c) : -1 : 1
        y = (y .* t) + p.c(i); 
    end
end
