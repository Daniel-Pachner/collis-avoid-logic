function collisiondiagramplot(t0, t1, s1, t2, s2, v0, a0, jM, aM, T)

    obst = obstacle2pwp(t1, s1, t2, s2);
    t = brakebreakpoints(t0, v0, a0, jM, aM, T);
    ps = stopmanpwp(t, v0, a0, jM, aM, 0);
    hx = stopmanplot(t0, v0, a0, jM, aM, T, 0);
    hxo = pwpplot(gca, obst, 'r', 'displayname', 'obstacle');
    d = pwpsubtract(ps, obst);
    hxd = pwpplot(gca, d, 'g', 'displayname', 'relative');
    [y, t] = pwpmax(d);
    hxwc = plot([t, t], [y, 0], 'r-o', 'displayname', 'close');
    legend([hx, hxo, hxd, hxwc]);

end
