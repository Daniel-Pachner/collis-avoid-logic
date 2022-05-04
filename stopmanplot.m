function hh = stopmanplot(t0, v0, a0, jM, aM, T, dmax = 3)

t = brakebreakpoints(t0, v0, a0, jM, aM, T);

titles = {'Distance', 'Speed', 'Acceleration', 'Jerk'};
names = {'tramdist', 'tramspeed', 'tramacc', 'tramjerk'};

aa = [];
hh = [];
for d = dmax : -1 : 0
    pr = stopmanpwp(t, v0, a0, jM, aM, d);
    if dmax > 0
        a = subplot(dmax+1, 1, d + 1);
    else
        a = gca;
    end
    pwppatch(a, pr, 'patchnames', {'Delay', 'Jerk-', 'Decelerate', 'Jerk+', 'Still'});
    hold(a, 'on');
    title(a, titles{d + 1});
    h = pwpplot(a, pr, 'k', 'displayname', names{d + 1});
    aa = [aa, a];
    hh = [hh, h];
end

xlabel(aa(1), 'time');

if dmax > 0
    linkaxes(aa, 'x');
    for k = 1 : dmax + 1
        axis(aa(k), 'tight');
    end
end

