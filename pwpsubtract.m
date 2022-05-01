function r1 = pwpsubtract(p1, p2)
    [r1, r2] = pwpmerge(p1, p2);
    for i = 1 : numel(r1)
        if polyorder(r2(i)) <= 2
            r1(i).c(1 : 2) = r1(i).c(1 : 2) - ...
            r2(i).c(1 : 2);
            r1(i).c(1) = r1(i).c(1) +  r2(i).c(2)*(r2(i).t0 - r1(i).t0);
        else
            fprintf('pwsubtract: second arg not linpoly');
        end
    end
end

