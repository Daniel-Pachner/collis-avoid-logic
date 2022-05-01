function hx = pwpplot(ax, p, varargin)
    [t, y] = pwpdomain(p, 50);
    [to, yo] = pwpdomain(p, 0);
    h = plot(ax, to, yo, varargin{:}, t, y, varargin{:});
    if numel(h) > 1
        cl = get(h(2), 'color');
        set(h(1), 'linestyle', 'none', 'marker', 'o', 'markersize', 3, ...
        'color', cl, 'markerfacecolor', cl)
        grid(ax, 'on');
        hx = h(2);
    else
        hx = zeros(1, 0);
    end
end

