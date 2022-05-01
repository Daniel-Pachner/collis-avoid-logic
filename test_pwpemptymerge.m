c = [
    0,      0,       1
    1,      2,      0];
q = polynomial(c); 
domains = [0, 1, 2.9];
t0 = [0, 1];
p1 = pwp(q, domains, t0);

c = [
    0.1    1,    0
    1.1,   2,   .3];
q = polynomial(c); 
domains = [3, 4, 5];
t0 = [3, 4];
p2 = pwp(q, domains, t0);

tic
[r1, r2] = pwpmerge(p1, p2);
toc

figure(1)

a2 = subplot(2, 1, 1);
hold(a2, 'off');
pwpplot(a2, p1, 'r');
hold(a2, 'on');
pwpplot(a2, p2, 'b');

a1 = subplot(2, 1, 2);
hold(a1, 'off');
pwppatch(a1, r1);
hold(a1, 'on');
pwpplot(a1, r1, 'r');
pwpplot(a1, r2, 'b');

linkaxes([a2, a1], 'xy')
