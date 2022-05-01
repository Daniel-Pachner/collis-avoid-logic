c = [
0,      1,      1
2,      0,     -1];
q = polynomial(c); 
domains = [0, 1, 2];
t0 = [0, 1];
p1 = pwp(q, domains, t0);

c = [
1.3,      1.0
2.3,      0.5];
q = polynomial(c); 
domains = [0.3, 1.3, 2.3];
t0 = [0.3, 1.3];
p2 = pwp(q, domains, t0);


d = pwpsubtract(p1, p2);

close all
figure(1)

a = gca;
hold(a, 'off');
pwpplot(a, p1, 'r', 'displayname', 'poly-1');
hold(a, 'on');
pwpplot(a, p2, 'b', 'displayname', 'poly-2');
pwpplot(a, d, 'k', 'displayname', 'poly-1 - poly-2');

[t, y] = pwpdomain(d, 12);
d2 = pwpevaln(p1, t) - pwpevaln(p2, t);
plot(a, t, d2, 'ms', 'displayname', 'empirical');
grid(a, 'on')

y = pwpmax(d);
[to, yo] = pwpdomain(d, 0);
plot(to, ones(size(to))*y, 'r-', ...
'linewidth', 2, 'displayname', 'max', 'displayname', 'max diff')
title(sprintf('max diff = %d', y))

legend

