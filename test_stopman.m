close all

figure(1)
collisiondiagramplot(T, t1, s1, t2, s2, v0, a0, jM, aM, T);

fprintf('min rel distance = %0.4g m at %0.4g s\n', -y, t);
[tmin, vmin, smin] = collisiontest(t0, v0, a0, jM, aM, t1, s1, t2, s2, T);
fprintf('smin = %0.3g\n', smin)

t0_x = timetomaneuver(t1, s1, t2, s2, v0, a0, jM, aM, T);
fprintf('time to maneuver = %0.3g\n', t0_x);

figure(2)
collisiondiagramplot(t0_x, t1, s1, t2, s2, v0, a0, jM, aM, T);

figure(3)
stopmanplot(t0_x, v0, a0, jM, aM, T, 3);



