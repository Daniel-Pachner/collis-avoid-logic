function pr = obstacle2pwp(t1, s1, t2, s2)
    p = polynomial([(t1*s2 - t2*s1)/(t1 - t2), (s2 - s1)/(t2 - t1)]);
    pr = pwp(p, [t1, t2], 0);
end
