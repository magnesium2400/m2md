function ssMerged = mergeFlatStructures( ssInto, ssFrom)
    % mergeFlatStructures  merges and overwrites fields flat structures
    % Depreciated.  Use mergeNestedStructures()
    %  - only works for flat scalar structures
    %  - no checking.
    ff = fieldnames( ssFrom );
    for i = 1:length(ff)
        ssInto.(ff{i}) = ssFrom.(ff{i});
    end
    ssMerged = ssInto;
end
