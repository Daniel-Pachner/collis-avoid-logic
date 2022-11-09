#include "cas_manual_tests.h"


//==========================================================================
// basic tests
void polytest() {
    std::cout << std::endl << "test of polynomial class" << std::endl;

    float C[4] = {0.0,  1.0, -1.0,  0.0};
    float t[4] = {0.0,  0.5,  1.0,  2.0};
    float tmax;

    Poly p(C); // test constructing a polynomial
    p.display(); // display it
    Poly q = p; // copy it
    std::cout << "copied polynomial" << std::endl;
    q.display(); // display the copy (should be the same)
    std::cout << "degree = " << p.polydegree() << std::endl; // polynomial degree
    for (int i = 0; i < 4; i++) {
        std::cout << "value at t = " << t[i] << " is " << p.polyval(t[i]) << std::endl;
    }
    std::cout << "polynomial maximization" << std::endl;
    std::cout << "maximum value over = [" << t[0] << ", " << t[3] << "] is " <<
    p.maxpolyval(t[0], t[3], &tmax) << " at " << tmax << std::endl;
    return;
}

// interval polynomial test
void polyinttest() {
    std::cout << std::endl << "test of interval polynomial class" << std::endl;
    float tmax;

    float C[4] = {0.0,  1.0, -1.1,  0.3};
    //float C[4] = {0.0,  1.0, -1.1,  0.0};
    Poly p(C);
    Polyint ai(p.c, 0.0, 0.0, 1.0);
    ai.display();
    std::cout << "maximum = over [" << ai.t1 << ", " << ai.t2 << "] " <<
    ai.maxpolyval(&tmax) << " at " << tmax << std::endl;

    Polyint bi = ai;
    std::cout << "copied polynomial" << std::endl;
    bi.display();
    std::cout << "maximum = over [" << bi.t1 << ", " << bi.t2 << "] " <<
    bi.maxpolyval(&tmax) << " at " << tmax << std::endl;

    float y = -FLT_MAX, tmp, tmax2;
    float dt = (bi.t2 - bi.t1) / 1000.0;
    for (float t = tmax - 0.1; t <= bi.t2 + 0.1; t += dt) {
        tmp = bi.polyval(t);
        if (y < tmp) {
            y = tmp;
            tmax2 = t;
        }
    }
    std::cout << "empirical maximum = over [" << bi.t1 << ", " << bi.t2 << "] " <<
    y << " at " << tmax2 << std::endl;
    return;
}

// interval polynomial test
void polyintarraytest() {
    std::cout << std::endl << "test of interval polynomial array class" << std::endl;
    float tmax;
    float C1[4] = {0.0, 1.0, 0.0, 0.0};
    float C2[4] = {1.0, 1.0, -1.0, 0.0};
    Polyint ip1(C1, 0.0, 0.0, 1.0);
    Polyint ip2(C2, 1.0, 1.0, 2.0);
    Polyintarray pa;
    pa.push(ip1);
    pa.push(ip2);
    pa.display();

    float dt = (ip2.t2 - ip1.t1) / 30.0;
    for (float t = ip1.t1; t <= 1.5*ip2.t2; t += dt) {
        std::cout << "p(" << t << ") = " << pa.polyval(t) << std::endl;
    }
    std::cout << "array maximization" << std::endl;
    std::cout << "maximum = " << pa.maxpolyval(&tmax) << " at " << tmax << std::endl;
    std::cout << "maximization of the first element" << std::endl;
    std::cout << "maximum = " << pa.p[0].maxpolyval(&tmax) << " at " << tmax << std::endl;
    std::cout << "maximization of the second element" << std::endl;
    std::cout << "maximum = " << pa.p[1].maxpolyval(&tmax) << " at " << tmax << std::endl;

    return;
}

// test of two piece wise polynomials merge (subintervals overlaps)
void ovelaptest() {
    std::cout << std::endl << "test of interval polynomials overlap" << std::endl;
    intoverlap S[5];
    float C1[4] = {0.0, -1.0, 0.0, 0.0};
    float C2[4] = {-1.0, 2.0, 0.0, 0.0};
    float C3[4] = {1.0, -0.1, 0.0, 0.0};
    float C4[4] = {1.0, -0.1, 0.0, 0.0};

    Polyint ip1(C1, 0.0, 0.0, 1.0);
    Polyint ip2(C2, 0.0, 1.0, 2.3);
    Polyint ip3(C2, 0.0, 2.3, 4.0);

    Polyint iq1(C3, 0.0, 1.5, 2.2);
    Polyint iq2(C4, 0.0, 2.2, 3.0);
    Polyintarray pa, pb;

    pa.push(ip1);
    pa.push(ip2);
    pa.push(ip3);

    pb.push(iq1);
    pb.push(iq2);

    pa.display();
    pb.display();

    findoverlap(S, pa, pb);
    for (int i = 0; i < 5; i++) {
        if (S[i].valid) {
            std::cout << "sub interval #" << i << " -- " << "[" << S[i].t1 << ", " << S[i].t2 << "]" <<
            "  {" << S[i].i << ", " << S[i].j << "}" << std::endl;
        }
    }
    return;
}

// time breakpoints test
void breakpointtest() {
    float t[5];
    float tmax = 30.0;
    float a0 = 0.0;
    float t0 = 1.0;
    float v0 = 10.0;
    float aM = -2.0;
    float jM = -1.5;
    breakpoints5(t, t0, v0, a0, jM, aM, tmax);
    std::cout << "initial values:\nv0 = " << v0 << "\na0 = " << a0 << "\nt0 = " << t0 << std::endl;
    std::cout << "limits:\naM = " << aM << "\njM = " << jM << std::endl;
    for (int i = 0; i <= 4; i++) {
        std::cout << "breakpoint times:t[" << i << "] = " << t[i] << std::endl;
    }
    std::cout << std::endl;
    return;
}

// test - obstacle converted to interval polynomial array
void obstacletest() {
    float t1 = 0.0;
    float t2 = 30.0;
    float s1 = 50.0;
    float s2 = 50.0;
    Polyintarray obstacle;
    obtacle2polyintarray(&obstacle, t1, s1, t2, s2);
    obstacle.display();
    return;
}

// test - standard stopping maneuver as piece-wise polynomial function
void stopmanpolyarraytest() {
    float t0 = 1.0;
    float v0 = 10.0;
    float a0 = 0.0;
    float jM = -1.5;
    float aM = -2.0;
    float tmax = 30.0;
    Polyintarray ps, pv, pa;
    stopmanpolyarray(&ps, &pv, &pa, v0, a0, t0, jM, aM, tmax);
    std::cout << "acceleration = " << std::endl;
    pa.display();
    std::cout << "velocity = " << std::endl;
    pv.display();
    std::cout << "distance = " << std::endl;
    ps.display();
}

// test - stopping maneuver distance from an obstacle section line
void distfromobstacletest() {
    float t0 = 1.0;
    float v0 = 10.0;
    float a0 = 0.0;
    float jM = -1.5;
    float aM = -2.0;

    float t1 = 5.0;
    float t2 = 10.0;
    float s1 = 40.0;
    float s2 = 45.0;

    Polyintarray d;
    distfromobstacle(&d, t1, s1, t2, s2, v0, a0, t0, jM, aM);

    d.display();

    // minimizing
    float t;
    float mind = d.maxpolyval(&t);
    std::cout << "Minimum distance = " << mind << " at time " << t << std::endl;

    // alternative function returns minimum directly
    float mint, inid;
    mind = mindistfromobstacle(&mint, &inid, t1, s1, t2, s2, v0, a0, t0, jM, aM);
    std::cout << "Minimum distance = " << mind << " at time " << mint << std::endl;
    std::cout << "Initial distance = " << inid << " at time " << t1 << std::endl;
    return;
}

// test - time to maneuver
void timetomaneuvertest() {
    float v0 = 10.0;
    float a0 = 0.0;
    float jM = -1.5;
    float aM = -2.0;

    float t1 = 3.0;
    float t2 = 10.0;
    float s1 = 40.0;
    float s2 = 45.0;

    float t0 = timetomaneuver(t1, s1, t2, s2, v0, a0, jM, aM);
    std::cout << "Time to maneuver = " << t0 << " seconds" << std::endl;
    return;
}

// =========================================================================
