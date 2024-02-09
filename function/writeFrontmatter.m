function fm = writeFrontmatter(filepath, dataStruct)

[origFm, origIdx] = readFrontmatter(filepath);
file = readlines(filepath);

if isempty(fieldnames(origFm)) % if no frontmatter
    fm = string(cellfun(@(x) strcat(x, ": ", dataStruct.(x)), fieldnames(dataStruct), 'uni', 0));
    file = ["---"; fm; "---"; ""; file];
else % add to pre-existing frontmatter
    newFm = mergeStructures(origFm, dataStruct);
    fm = string(cellfun(@(x) strcat(x, ": ", newFm.(x)), fieldnames(newFm), 'uni', 0));
    file = [file(1:origIdx(1)-1); fm; file((origIdx(2)+1):end)];
end

fid = fopen(filepath, 'wt');
fwrite(fid, join(file, newline));
% fprintf(fid, '%s%s', file, newline);
fclose(fid);
% writelines(file, filepath);

end
