// =========================================================================
// simple polynomial up to cubic

#include "poly.h"

float Poly::tol = 1e-6;

Poly::Poly() {
    for(int i = 0; i <= 3; i++) {
        c[i] = 0;
    }
    return;
};

Poly::Poly(const Poly &p) {
    for(int i = 0; i <= 3; i++) {
        c[i] = p.c[i];
    }
    return;
};

Poly::Poly(float *carray) {
    for(int i = 0; i <= 3; i++) {
        c[i] = carray[i];
    }
    return;
}

float Poly::polyval(float t) {
    float y = 0.0;
    for (int i = 3; i >= 0; i--) {
        y *= t;
        y += c[i];
    }
    return y;
}

float Poly::maxpolyval(float t1, float t2, float *s) {
    int n = polydegree();
    float t = t1, y = polyval(t1), y2 = polyval(t2), t3, y3;
    if (y2 > y) {
        y = y2;
        t = t2;
    }
    if (n == 2) {
        float t3 = -c[1]/(2*c[2]);
        if ((t3 > t1) && (t3 < t2)) {
            y3 = polyval(t3);
            if (y3 > y) {
                y = y3;
                t = t3;
            }
        }
    } else if (n == 3) {
        float d = c[2]*c[2] - 3.0*c[3]*c[1];
        if (d >= 0.0) {
            for (int s = -1; s <= 1; s += 2) {
                t3 = -(c[2] + s*sqrt(d)) / (3.0*c[3]);
                if ((t3 > t1) && (t3 < t2)) {
                    y3 = polyval(t3);
                    if (y3 > y) {
                        y = y3;
                        t = t3;
                    }
                }
            }
        }
    }
    if (s != NULL)
        *s = t;
    return y;
}

int Poly::polydegree() {
    int i = 3;
    while (abs(c[i]) < tol)
        i--;
    return i;
}

void Poly::display() {
    int m = polydegree(), pass = 0;
    std::cout << "P(t) = ";
    for(int i = 0; i <= m; i++) {
        if (abs(c[i]) > 0.0) {
            if ((c[i] > 0) && pass)
                std::cout << " + ";
            else
                if ((c[i] < 0) && pass)
                    std::cout << " - ";
                else if (c[i] < 0)
                        std::cout << "-";
            if ((i == 0) || (abs(c[i]) != 1.0))
            {
                std::cout << abs(c[i]);
                if (i > 0) std::cout << "*";
            }
            if (i > 0)
                std::cout << "t";
            if (i > 1)
                std::cout << "^" << i;
            pass = 1;
        }
    }
    if (m < 0)
        std::cout << 0;
    std::cout << std::endl;
    return;
}

// =========================================================================
// simple polynomial on an interval

Polyint::Polyint(float *carray, float origin, float lowerbound, float upperbound) : Poly(carray) {
    t0 = origin;
    t1 = lowerbound;
    t2 = upperbound;
    return;
}

Polyint::Polyint() : Poly() {
    t0 = 0.0;
    t1 = 0.0;
    t2 = 0.0;
    return;
}

Polyint::Polyint(const Polyint &p) : Poly(p) {
    t0 = p.t0;
    t1 = p.t1;
    t2 = p.t2;
    return;
}

float Polyint::polyval(float t) {
    return Poly::polyval(t - t0);
}

float Polyint::maxpolyval(float *s) {
    float y = Poly::maxpolyval(t1 - t0, t2 - t0, s);
    *s = *s + t0;
    return y;
}

void Polyint::display() {
    std::cout << "<" << t1 << ", " << t2 << "> ";
    std::cout << "t0 = " << t0 << " ";
    Poly::display();
    return;
}

// =========================================================================
// array of interval polynomials as a piece-wise polynomial function

Polyintarray::Polyintarray() {
    n = 0;
    for (int i = 0; i < 5; i++) {
        p[i] = Polyint();
    }
    return;
}

float Polyintarray::polyval(float t) {
    float y = 0.0;
    float s = p[0].t1;
    if (t < p[0].t1)
        t = p[0].t1;
    else if (t > p[n-1].t2)
        t = p[n-1].t2;
    for(int i = 0; i < n; i++) {
        if ((t >= s) && (t <= p[i].t2)) {
            y = p[i].polyval(t);
        }
        s = p[i].t2;
    }
    return y;
}

float Polyintarray::maxpolyval(float *t) {
    float y = -FLT_MAX, ti, yi;
    *t = 0.0;
    for (int i = 0; i < n; i++) {
        yi = p[i].maxpolyval(&ti);
        if (yi > y) {
            y = yi;
            *t = ti;
        }
    }
    return y;
}

void Polyintarray::push(Polyint q) {
    if (n < 5) {
        p[n] = q;
        n = n + 1;
    }
    return;
}

void Polyintarray::display() {
    std::cout << "array A of " << n << " polynomials P" << std::endl;
    for (int i = 0; i < n; i++) {
        std::cout << "A[" << i << "]: ";
        p[i].display();
    }
    return;
}

// =========================================================================
// operations over arrays of interval polynomials

void findoverlap(intoverlap *S, Polyintarray a, Polyintarray b) {
    int ai = 0, bi = 0, j = 0, da = 0, db = 0;
    float t1 = 0, t2 = 0;

    if (a.p[ai].t1 > b.p[bi].t1) {
        t1 = a.p[ai].t1;
        while ((bi < b.n) && (b.p[bi].t2 <= t1))
            bi++;
    } else {
        t1 = b.p[bi].t1;
        while ((ai < a.n) && (a.p[ai].t2 < t1))
            ai++;
    }

    while ((ai < a.n) && (bi < b.n) && j < 5) {
        if (a.p[ai].t2 < b.p[bi].t2)  {
            t2 = a.p[ai].t2;
            da = 1;
            db = 0;
        } else {
            t2 = b.p[bi].t2;
            da = 0;
            db = 1;
        }
        if ((t2 - t1) > 0) {
            S[j].t1 = t1;
            S[j].t2 = t2;
            S[j].i = ai;
            S[j].j = bi;
            S[j].valid = 1;
            j++;
        }
        ai += da;
        bi += db;
        t1 = t2;

    }
    while (j < 5)
        S[j++].valid = 0;
    return;
}
