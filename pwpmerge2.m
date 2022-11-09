function [a, b] = pwpmerge2(a, b)
    
    ai = 1;
    bi = 1;
    
    if a(ai).t1 > b(bi).t1
        t1 = a(ai).t1;
        while  bi <= numel(b) && b(bi).t2 <= t1
            bi = bi+1;
        end
    else
        t1 = b(bi).t1;
        while  ai <= numel(a) && a(ai).t2 <= t1
            ai = ai+1;
        end
    end    
    
    while true
        if ai > numel(a) || bi > numel(b)
            break;
        end
        
        if a(ai).t2 < b(bi).t2
            t2 = a(ai).t2;
            da = 1;
            db = 0;
        else
            t2 = b(bi).t2;
            da = 0;
            db = 1;            
        end
        
        disp([ai bi t1 t2])            
        ai = ai + da;
        bi = bi + db;
        t1 = t2;
    end
    
    
end
