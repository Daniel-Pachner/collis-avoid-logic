d = dir('.');
for i = 1 : numel(d)
    if ~d(i).isdir && ~isempty(strfind(d(i).name, '.ofig'))
        j = strfind(d(i).name, '.ofig');
        figfname = d(i).name;
        pngfname = [d(i).name(1:j-1), '.png'];
        fprintf('%s -> %s\n', figfname, pngfname);
        open(d(i).name);
        set(gcf, 'position', [-1652     52   1339    842]);
        saveas(gcf, pngfname);
    end
end

