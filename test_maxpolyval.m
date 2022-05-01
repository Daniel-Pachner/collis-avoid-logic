t1 = -1.5;
t2 = +1.5;

c = [
    1,  -4,     -4,     3;
   -1,  -1,     -4,     0;
    2,   3,      0,     0;
    4,   0,      0,     0];

p = polynomial(c);
    
n = 40;

t = linspace(t1, t2, n);

figure(1)
title('max poly value in interval')
for k = 1 : 4
    subplot(2, 2, k)
    [ym, tm] = maxpolyval(p(k), t1, t2);
    plot(t, polyval(p(k), t), t, ym*ones(1, n), 'r-', tm, ym, 'rs');
end

