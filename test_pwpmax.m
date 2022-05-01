c = [
    0,   0,      1
    1,  -2,      0
   -1,   1.9,    0];
    
q = polynomial(c); 
domains = [0, 1, 2, 3];
isrelative = [true, true];
pr = pwp(q, domains, [0, 1, 2]);

close all
figure(1)
a = gca;
hold(a, 'off');
pwppatch(gca, pr);
hold(a, 'on');
hx = pwpplot(a, pr, 'r-', 'displayname', 'pwpoly');

[y, t] = pwpmax(pr);
[to, yo] = pwpdomain(pr, 0);
hy = plot(to, ones(size(to))*y, 'g-', ...
'linewidth', 2, 'displayname', 'max')
plot(t, y, 'bo', 'markersize', 7)

legend([hx, hy])