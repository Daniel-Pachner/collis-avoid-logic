function [t, v, s, s0] = collisiontest(t0, v0, a0, jM, aM, t1, s1, t2, s2, T)
    t = brakebreakpoints(t0, v0, a0, jM, aM, T);
    ps = stopmanpwp(t, v0, a0, jM, aM, 0);
    pv = stopmanpwp(t, v0, a0, jM, aM, 1);
    obst = obstacle2pwp(t1, s1, t2, s2);
    d = pwpsubtract(ps, obst);
    [s, t] = pwpmax(d);
    v = pwpeval(pv, t);
    s0 = pwpeval(d, t1);
end
