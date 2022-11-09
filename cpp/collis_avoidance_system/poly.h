#ifndef POLY_H
#define POLY_H

#include <iostream>
#include <math.h>
#include <float.h>
#include "poly.h"


class Poly {
public:
    static float tol;
    float c[4];
public:
    Poly(float *c);
    Poly();
    Poly(const Poly &);
    float polyval(float);
    float maxpolyval(float, float, float*);
    int polydegree();
    void display();
};

class Polyint: public Poly {
public:
    float t0, t1, t2;
public:
    Polyint(float*, float, float, float);
    Polyint();
    Polyint(const Polyint &);
    float maxpolyval(float*);
    float polyval(float);
    void display();
};

class Polyintarray{
public:
    Polyint p[5];
    int n;
    Polyintarray();
    float maxpolyval(float*);
    float polyval(float);
    void push(Polyint);
    void display();
};

struct intoverlap {
    float t1;
    float t2;
    int i;
    int j;
    int valid;
};

#endif //POLY_H
