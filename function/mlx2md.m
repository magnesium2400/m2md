function mlx2md(filename)

export(sprintf('%s.mlx', filename), 'Format', 'latex', 'FigureFormat', 'png');

latex2markdown(filename);



end