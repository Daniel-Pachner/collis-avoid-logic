#include "cas_auto_tests.h"

void castest()
{
    float t1, s1, t2, s2;
    float v0, a0, aM, jM;
    float t0;

    std::ifstream fin;
    std::ofstream fout;
    fin.open("casin.csv", std::ios::in);
    fout.open("casout.csv", std::ios::out);

    std::vector<std::string> row;
    std::string line, word, temp;

    while (true) {
        row.clear();
        getline(fin, line);

        if (line.empty())
            break;

        std::stringstream s(line);
        while (getline(s, word, ',')) {
            row.push_back(word);
        }

        t1 = std::stof(row[0]);
        s1 = std::stof(row[1]);
        t2 = std::stof(row[2]);
        s2 = std::stof(row[3]);
        v0 = std::stof(row[4]);
        a0 = std::stof(row[5]);
        v0 = std::stof(row[4]);
        a0 = std::stof(row[5]);
        aM = std::stof(row[6]);
        jM = std::stof(row[7]);
        t0 = timetomaneuver(t1, s1, t2, s2, v0, a0, jM, aM);

        fout << t1 << ",\t";
        fout << s1 << ",\t";
        fout << t2 << ",\t";
        fout << s2 << ",\t";
        fout << v0 << ",\t";
        fout << a0 << ",\t";
        fout << aM << ",\t";
        fout << jM << ",\t";
        fout << t0 << ",\n";
    }
    fin.close();
    return;
}
