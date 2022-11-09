#ifndef CAS_H
#define CAS_H

#include "poly.h"

float timetomaneuver(float, float, float, float, float, float, float, float);

void distfromobstacle(Polyintarray*, float, float, float, float,
                      float, float, float, float, float);

void stopmanpolyarray(Polyintarray*, Polyintarray*, Polyintarray*,
                      float, float, float, float, float, float);

void obtacle2polyintarray(Polyintarray*, float, float, float, float);

void breakpoints5(float*, float, float, float, float, float, float);

void findoverlap(intoverlap*, Polyintarray, Polyintarray);

float mindistfromobstacle(float*, float*, float, float, float, float,
                      float, float, float, float, float);

#endif //CAS_H
