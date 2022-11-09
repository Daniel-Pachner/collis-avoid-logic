v0 = 10;
a0 = 0;
jM = -1.5;

t1 = 3;
t2 = 10;
s1 = 40;
s2 = 45;
obst = obstacle2pwp(t1, s1, t2, s2);
T = t2;

t0 = [2.5, 2, 1.5, 1];
aM = [-2.0, -2.5, -3.0, -4.0];

close all
for i = 1 : 4
    hax(i) = subplot(2, 4, i);
    hx = stopmanplot(t0(i), v0, a0, jM, aM(1), T, 0);
    hxo = pwpplot(hax(i), obst, 'r', 'displayname', 'obstacle');

    t = brakebreakpoints(t0(i), v0, a0, jM, aM, T);
    ps = stopmanpwp(t, v0, a0, jM, aM, 0);
    d = pwpsubtract(ps, obst);
    [ymax, t] = pwpmax(d);
    y0 = pwpeval(d, t1);
    title(hax(i), sprintf('y0=%0.1f ymax=%0.1f', y0, ymax), 'FontSize', 14);
end

%%obst = obstacle2pwp(t1-t0(4), s1-v0*t0(4), t2-t0(4), s2-v0*t0(4));
for i = 5 : 8
    hax(i) = subplot(2, 4, i);
    hx = stopmanplot(0, v0, a0, jM, aM(i-4), T, 0);
    hxo = pwpplot(hax(i), obst, 'r', 'displayname', 'obstacle');

    t = brakebreakpoints(0, v0, a0, jM, aM(i-4), T);
    ps = stopmanpwp(t, v0, a0, jM, aM, 0);
    d = pwpsubtract(ps, obst);
    [ymax, t] = pwpmax(d);
    y0 = pwpeval(d, t1);
    title(hax(i), sprintf('y0=%0.1f ymax=%0.1f', y0, ymax), 'FontSize', 14);
end

linkaxes(hax, 'x')
linkaxes(hax, 'y')

