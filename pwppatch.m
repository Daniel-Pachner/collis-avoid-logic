function pwppatch(ax, p, varargin)
    j = strcmp(varargin, 'patchnames');
    if any(j)
        patchnames = varargin{1 + find(j, 1, 'last')};
    else
        patchnames = {};
    end

    [t, y] = pwpdomain(p, 50);
    yl = min(y);
    yr = max(y);
    cm = colormap('lines');
    for i = 1 : numel(p)
        j = mod(i-1, size(cm, 1)) + i;
        if p(i).t2 - p(i).t1 > 0.01
            patch(ax, [p(i).t1, p(i).t2, p(i).t2, p(i).t1, p(i).t1], ...
            [yl, yl, yr, yr, yl], cm(j, :), 'facealpha', 0.5, 'edgealpha', 0);
            if numel(patchnames) >= i && ~isempty(patchnames{i})
                text(0.5*(p(i).t1 + p(i).t2), 0.5*(yl + yr), patchnames{i}, ...
                'FontSize', 12, 'HorizontalAlignment', 'Center');
            end
        end
    end
end
