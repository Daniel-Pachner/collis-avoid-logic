// =========================================================================
// an obstacle section line to interval polynomial array

#include "cas.h"

void obtacle2polyintarray(Polyintarray *a, float t1, float s1, float t2, float s2) {
    Polyint p;
    p.c[0] = (t1*s2 - t2*s1) / (t1 - t2);
    p.c[1] = (s2 - s1) / (t2 - t1);
    p.t1 = t1;
    p.t2 = t2;
    a->push(p);
    return;
}

// =========================================================================
// stopping maneuver breakpoints

// case without delay
void breakpoints3(float* t, float v0, float a0, float jM, float aM) {
    float tmp = a0/jM;
    t[3] = sqrt((tmp*tmp) / 2.0 - v0 / jM);
    t[2] = 0.0;
    t[1] = t[3] - tmp;
    if (t[1] < 0.0) {
        t[1] = 0.0;
        t[3] = (a0 + sqrt(a0*a0 + 2.0*jM*v0)) / jM;
    } else {
        float a1 = a0 + jM*t[1];
        if (a1 < aM) {
            t[1] = (aM - a0) / jM;
            t[3] = aM / jM;
            float v2 = -(aM*aM) / (2*jM);
            float v1 = v0 + a0*t[1] + jM*t[1]*t[1] / 2.0;
            t[2] = (v2 - v1) / aM;
        }
    }
    return;
}

// case with delay
void breakpoints5(float* t, float t0, float v0, float a0, float jM, float aM, float tmax) {
    t[0] = t0;
    breakpoints3(t, v0 + a0*t0, a0, jM, aM);
    t[4] = tmax;
    for (int i = 0; i <= 3; i++)
        t[4] -= t[i];
    t[4] = t[4] < 0.0 ? 0.0 : t[4];
    return;
}

// stopping maneuver polynomial array
void stopmanpolyarray(Polyintarray *psa, Polyintarray *pva, Polyintarray *paa,
                      float v0, float a0, float t0, float jM, float aM, float tmax) {
    float j[5] = {0.0, 0.0, 0.0, 0.0, 0.0};
    float a[5] = {0.0, 0.0, 0.0, 0.0, 0.0};
    float v[5] = {0.0, 0.0, 0.0, 0.0, 0.0};
    float s[5] = {0.0, 0.0, 0.0, 0.0, 0.0};

    float t1 = 0.0, t2, t[5];
    int i, k;

    breakpoints5(t, t0, v0, a0, jM, aM, tmax);

    j[1] = +jM;
    j[3] = -jM;
    a[0] = +a0;
    v[0] = +v0;

    Polyint ap;
    Polyint vp;
    Polyint sp;

    for (i = 0; i <= 4; i++) {
        ap.c[0] = a[i];
        ap.c[1] = j[i];

        vp.c[0] = v[i];
        vp.c[1] = a[i];
        vp.c[2] = j[i]/2.0;

        sp.c[0] = s[i];
        sp.c[1] = v[i];
        sp.c[2] = a[i]/2.0;
        sp.c[3] = j[i]/6.0;

        t2 = t1 + t[i];

        sp.t1 = t1;
        sp.t2 = t2;
        sp.t0 = t1;

        vp.t1 = t1;
        vp.t2 = t2;
        vp.t0 = t1;

        ap.t1 = t1;
        ap.t2 = t2;
        ap.t0 = t1;

        psa->push(sp);
        pva->push(vp);
        paa->push(ap);

        k = i + 1;
        a[k] = ap.polyval(t2);
        v[k] = vp.polyval(t2);
        s[k] = sp.polyval(t2);

        t1 = t2;
    }
    return;
}

// distance of the stopping maneuver from obstacle
void distfromobstacle(Polyintarray *d, float t1, float s1, float t2, float s2,
                      float v0, float a0, float t0, float jM, float aM) {
    intoverlap S[5];
    Polyintarray obstacle;
    obtacle2polyintarray(&obstacle, t1, s1, t2, s2);
    Polyintarray ps, pv, pa;
    stopmanpolyarray(&ps, &pv, &pa, v0, a0, t0, jM, aM, t2);
    findoverlap(S, ps, obstacle);
    Polyint p;
    for (int i = 0; i < 5; i++) {
        if (S[i].valid) {
                p = ps.p[S[i].i];
                p.c[0] -= obstacle.p[S[i].j].c[0] - obstacle.p[S[i].j].c[1] *
                (obstacle.p[S[i].j].t0 - ps.p[S[i].i].t0);
                p.c[1] -= obstacle.p[S[i].j].c[1];
                d->push(p);
        }
    }
    return;
}

// stopping maneuver minimum distance from an obstacle section line
float mindistfromobstacle(float *mindistt, float *inidist, float t1, float s1, float t2, float s2,
                      float v0, float a0, float t0, float jM, float aM) {
    Polyintarray d;
    distfromobstacle(&d, t1, s1, t2, s2, v0, a0, t0, jM, aM);
    *inidist = d.polyval(t1);
    float mindist = d.maxpolyval(mindistt);
    return mindist;
}

// time to stopping maneuver
float timetomaneuver(float t1, float s1, float t2, float s2,
                      float v0, float a0, float jM, float aM) {

    float inidist, mindistt, t0 = 5.0;
    while ((t0 > 0.0) &&
    (mindistfromobstacle(&mindistt, &inidist, t1, s1, t2, s2, v0, a0, t0, jM, aM) >= 0.0)) {
        if (inidist > 0.0)
            break;
        t0 = t0 - 0.5;
    }
    return t0;
}
