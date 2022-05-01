t = [1, 2, 2, 2, 1];

v0 = 10;
a0 = 0;
t0 = 0;
jM = -1.5;
aM = -2.0;

t1 = 0;
t2 = 7;
s1 = 30;
s2 = 30;
obst = obstacle2pwp(t1, s1, t2, s2);
T = t2;


%%    if t_0 > 0
%%        a0 = max(a0, -v0 / t_0);
%%    end
%%    aM = min(aM, a0)
%%    jM = min(jM, jerklimit(v0 + a0*t_0, a0))

figure(1)
stopmanplot(t0, v0, a0, jM, aM, T, 3);

figure(2)
t = brakebreakpoints(t0, v0, a0, jM, aM, T);
ps = stopmanpwp(t, v0, a0, jM, aM, 0);
hx = stopmanplot(t0, v0, a0, jM, aM, T, 0);
hxo = pwpplot(gca, obst, 'r', 'displayname', 'obstacle');
d = pwpsubtract(ps, obst);
hxd = pwpplot(gca, d, 'g', 'displayname', 'relative');
[y, t] = pwpmax(d);
hxwc = plot([t, t], [y, 0], 'r-o', 'displayname', 'close');
legend([hx, hxo, hxd, hxwc]);

fprintf('min rel distance = %0.4g m at %0.4g s\n', -y, t)

[t, v, s] = collisiontest(t0, v0, a0, jM, aM, t1, s1, t2, s2)