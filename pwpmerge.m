function [a, b] = pwpmerge(a, b)
    [r, j] = twopw(a, b);
    a = struct('t1', {r(1:j).t1}, 't2', {r(1:j).t2}, 'c', {a([r(1:j).i]).c}, ...
    't0', {a([r(1:j).i]).t0});
    b = struct('t1', {r(1:j).t1}, 't2', {r(1:j).t2}, 'c', {b([r(1:j).j]).c}, ...
    't0', {b([r(1:j).j]).t0}); 
end


function [r, j] = twopw(a, b)
    p = [a(1).t1, a.t2];
    q = [b(1).t1, b.t2];
    np = length(p);
    nq = length(q);
    n = np + nq + 1;
    z = zeros(1, n);
    r = struct('t1', num2cell(z), 't2', num2cell(z), ...
    'i', num2cell(z), 'j', num2cell(z), 'valid', num2cell(false(1, n))); 
    ip = 0;
    iq = 0;
    j = 0;
    t1 = Inf;
    t2 = Inf;
    for i = 1 : n
        if ip < np && iq < nq && p(ip+1) <= q(iq+1) || ip < np && iq >= nq
            ip = ip + 1;
            t1 = p(ip);
        elseif ip < np && iq < nq && q(iq+1) <= p(ip+1) || iq < nq && ip >= np 
            iq = iq + 1;
            t1 = q(iq);
        end
        
        if ip < np && iq < nq && p(ip+1) <= q(iq+1) || ip < np && iq >= nq
            t2 = p(ip + 1);
        elseif ip < np && iq < nq && q(iq+1) <= p(ip+1) || iq < nq && ip >= np 
            t2 = q(iq + 1);
        end
        
        if iq < nq && ip < np && ip > 0 && iq > 0 && t2 - t1 > 0
            j = j + 1;
            r(j) = struct('t1', t1, 't2', t2, 'i', ip, 'j', iq, 'valid', true);
        end
    end
end
