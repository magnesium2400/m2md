function [out, idx] = readFrontmatter(filepath)


file = readlines(filepath);
out = struct();

% find indices of '---' demarcations, exit if there aren't any
idx = cellfun(@(x) regexp(x, '---[\s]*')+0, file, 'UniformOutput', 0);
idx(cellfun(@isempty, idx)) = {0};
idx = find(cell2mat(idx));
if ~any(idx); return; end

beg = idx(1); % start of yaml
fin = idx(2); % end of yaml 

% check that there is no text before first '---'
idx2 = cellfun(@(x) regexp(x, '[\S]*')+0, file(1:(beg-1)), 'UniformOutput', 0);
if ~all(cellfun(@isempty, idx2)) % text exists before the first '---' demarcation
    return;
end

% yaml confirmed; now extract data
idx = [beg+1, fin-1];
yaml = cellfun(@strtrim, split(file(idx(1):idx(2)),':'), 'UniformOutput', 0);
if numel(yaml) == 2; yaml = reshape(yaml, 1, 2); end
out = cell2struct(yaml(:,2), yaml(:,1), 1);


end
