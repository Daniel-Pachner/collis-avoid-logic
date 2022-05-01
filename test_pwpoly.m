c = [
    0, 0, 1
    1, 2, 0];
q = polynomial(c); 
domains = [0, 1, 1.4];
pr = pwp(q, domains, [0, 1]);


% same piece-wise polynomial, not relative
c = [
    0, 0, 1
   -1, 2, 0];
q = polynomial(c); 
pa = pwp(q, domains, [0, 0]);

close all
figure(1)
hold(gca, 'off');
pwppatch(gca, pr);
hold(gca, 'on');
pwpplot(gca, pr, 'r-');
pwpplot(gca, pa, 'b.');
title('same polynomials')
