function t0_x = timetomaneuver(t1, s1, t2, s2, v0, a0, jM, aM, T)
    obst = obstacle2pwp(t1, s1, t2, s2);

    t0_a = 0;
    t0_b = t2;

    [~, ~, s_a, s0_a] = collisiontest(t0_a, v0, a0, jM, aM, t1, s1, t2, s2, T);
    [~, ~, s_b, s0_b] = collisiontest(t0_b, v0, a0, jM, aM, t1, s1, t2, s2, T);

    if s0_b >= 0
        t0_x = T;
    elseif s_b <= 0
        t0_x = T;
    else
        for halve = 1 : 50
            t0_x = (t0_a + t0_b) / 2;
            [~, ~, s_x, s0_x] = collisiontest(t0_x, v0, a0, jM, aM, t1, s1, t2, s2, T);
            if s_x <= 0
                t0_a = t0_x;
            else
                t0_b = t0_x;
            end
        end
        t0_x = t0_a;
    end
end
