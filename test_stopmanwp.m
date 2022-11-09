v0 = 10;
a0 = 0;
t0 = 1;
jM = -1.5;
aM = -2.0;

T = 30;
t = brakebreakpoints(t0, v0, a0, jM, aM, T);
ps = stopmanpwp(t, v0, a0, jM, aM, 0);
pv = stopmanpwp(t, v0, a0, jM, aM, 1);
pa = stopmanpwp(t, v0, a0, jM, aM, 2);