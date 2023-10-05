function [outputArg1,outputArg2] = m2mlx(filename)

matlab.internal.liveeditor.openAndSave(strcat(filename, '.m'), ...
    strcat(filename, '.mlx'));

end

