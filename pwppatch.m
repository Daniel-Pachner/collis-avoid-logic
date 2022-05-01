function pwppatch(ax, p, varargin)
    [t, y] = pwpdomain(p, 50);
    yl = min(y);
    yr = max(y);
    cm = colormap('lines');
    for i = 1 : numel(p)
        j = mod(i-1, size(cm, 1)) + i;
        patch(ax, [p(i).t1, p(i).t2, p(i).t2, p(i).t1, p(i).t1], ...
        [yl, yl, yr, yr, yl], cm(j, :), 'facealpha', 0.5, 'edgealpha', 0);
    end
end
