function t = brakebreakpoints(t0, v0, a0, jM, aM, T)
    t = brakebreakpoints3(v0 + a0*t0, a0, jM, aM);
    t4 = max(2.0, T - sum(t) - t0);
    t = [t0, t, t4];
end


function t = brakebreakpoints3(v0, a0, jM, aM)
    
    function t = stopmaneuver3(v0, a0, jM, aM)
        t1 = (aM - a0) / jM;
        t3 = aM / jM;
        v2 = -0.5*aM^2 / jM;
        v1 = v0 + a0 * t1 + (jM/2.0) * t1^2;
        t2 = (v2 - v1) / aM;
        t = [t1, t2, t3];
    end
    
    if v0 <= 0.0
        t = [0.0, 0.0, 0.0];
    else
        t3 = sqrt((a0/jM)^2/2.0 - v0/jM);
        t1 = t3 - a0/jM;
        if t1 < 0
            t3 = (a0 + sqrt(a0^2 + 2*jM*v0)) / jM;
            t = [0.0, 0.0, t3];
        else
            a_1 = a0 + jM*t1;
            if a_1 < aM
                t = stopmaneuver3(v0, a0, jM, aM);
            else
                t = [t1, 0.0, t3];
            end
        end
    end
end
