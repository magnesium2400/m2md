function [mdFile, texFile] = m2md(file, varargin)
%% m2md Convert MATLAB .m docstring/help to Markdown
%% Usage Notes
% Note: this README was generated using `m2md` and uses syntax dependent on
% MATLAB(R)'s PUBLISH function. However, it *requires the addition of the
% keyphrase `%% ENDPUBLISH` after the help/docstring to function*. See the help
% for the PUBLISH function and the associated Topic pages for more information
% on styling. For example, start lines with 1 space to show regular text; 2
% spaces for monospaced text; and 3 spaces for sample code. As much as possible,
% compatibility with both PUBLISH and HELP was maintained. This code is
% distributed as-is, but is accepting improvements (at least in 2023).
%% Syntax
%   m2md(file)
%   m2md
%   m2md("m2md-this-directory")
%   m2md([])
%   m2md(file, Name, Value)
%   mdFile = m2md(file,___)
%   [mdFile,texFile] = m2md(file,___)
%
%
%% Description
% `m2md(file)` converts the doctring or help of the specified MATLAB code file
% to a tex file and then into a Markdown file, using the functionality provided
% by PUBLISH and LATEX2MARKDOWN. It requires the addition of the keyphrase `%%
% ENDPUBLISH` after the help/docstring to function.
% 
% `m2md` converts all the `.m` files in the current directory (not in its
% subdirectories) using default specifications, and outputs the `.tex` and `.md`
% files in `./html`. `Contents.m`, if it exists, is (by default) output in the
% current directory (but this can be overridden). If more than half of the .m
% files in the current directory have been converted to .md files and placed in
% a sub-directory, m2md will try to guess the default settings that have been
% used. 
% 
% `m2md("m2md-this-directory")` uses the keyphrase "m2md-this-directory" to
% iterate over the MATLAB `.m` code files in the current directory. It can be
% combined with Name-Value pairs, and in particular with `recursiveSearch`.
% `Contents.m`, if it exists, is (by default) output in the current directory
% (but this can be overridden).
% 
% `m2md([])` does the same as the above i.e. iterates over all the `.m` files in
% the current directory. This can be combined with Name-Value pairs e.g. to
% change the output destination.
% 
% `m2md(file, Name, Value)` converts the specified MATLAB file with options
% specified by one or more `name,value` pair arguments. For example, you can
% specify custom options for generating the .tex and .md files, where to output
% the .tex or .md files, the name of the .md file, or whether to delete the .tex
% file.
%
% `mdFile = m2md(file, ___)` converts the specified MATLAB file and returns the
% relative path of the resulting .md file. You can use this syntax with any of 
% the input argument combinations in the previous syntaxes.
%
% `[mdFile, texFile] = m2md(file, ___)` converts the specified MATLAB file and
% returns the relative path of the resulting .md file and the full path of the
% .tex file. You can use this syntax with any of the input argument combinations
% in the previous syntaxes.
%
%
%% Examples
%   m2md("m2md");
%   m2md("m2md", 'mdDir', '.', 'mdFilename', 'README', 'deleteTex', true);
%   m2md([], 'mdDir', 'DOCS', 'deleteTex', true, 'recursiveSearch', false);
%
%
%% Input Arguments
%  file - MATLAB file name (character vector | string)
%  MATLAB file name, specified as a character vector or string. It should *NOT*
%  include the '.m' extension. *NOTE*: When publishing a file, this will
%  overwrite existing files in the target folders with the same name as `file`.
%
%
%% Name-Value Arguments
% `texOptions - Options to pass through to PUBLISH (cell array)` Name-Value
% arguments to be passed through when calling PUBLISH. The default behaviour is
% to set the format to latex and turn off the display and evaluation of code.
% These can be changed if desired, but is likely to significantly harm
% performance. See the Name-Value Arguemnts of PUBLISH for more information.
%   
% `mdOptions - Options to pass through to LATEX2MARKDOWN (cell array)`
% Name-Value arguments to be passed through when calling LATEX2MARKDOWN. Note
% that there is currently *NO* option to turn off the Table of Contents - this
% is autogenerated by PUBLISH. See the Instructions/docs for LATEX2MARKDOWN /
% LIVESCRIPT2MARKDOWN for more information.
%   
% `outputDir - Directory to create the tex and md files (string | character
% vector)` Output folder to which the tex and md files are saved. If no folder
% is specified, these will be output to the default specified by PUBLISH,
% `./html`.
%  
% `texDir - Directory to create the tex file only (string | character vector)`
% Output folder to which the tex file only is saved.
%  
% `mdDir - Directory to create the md file only (string | character vector)`
% Output folder to which the md file only is saved.
%
% `mdFilename - Name of the md file (string OR character vector)` Output file
% name to which the md file is saved.
%
% `deleteTex - Flag to delete tex file (false (default) | true)` Whether to
% delete the intermediary tex file, specified as `true` or `false`. If the tex
% file is deleted and its parent folder is empty, the parent folder
%  will then be deleted too.
%  
% `recursiveSearc - Flag to seach subdirectories when using
% "m2md-this-directory" (false (default) | true)` Whether to additionally search
% and create .md files for .m files located in the subdirectories of the present
% directory.
%  
% `contentsName - Filename to be used for Contents.m ('Contents' (default) |
% string | character vector)` Filename used for Contents.m if using
% `m2md("m2md-this-directory", ___)` or `m2md([], ___)`.
%  
% `contentsDir - Directory to be used for Contents.m ('.' (default) OR string OR
% character vector)` Directory used for Contents.m if using
% `m2md("m2md-this-directory", ___)` or `m2md([], ___)`.
%
%
%% Output Arguments
% `mdFile - Relative path to .md file (string | character vector)` The output
% filepath as generated by LATEX2MARKDOWN.
%
% `texFile - Full path to .tex file (character vector | string)` The output
% filepath as generated by PUBLISH.
%
%
%% Tips
% * In order to demarcate the end of the docstring: create a section entitled
% ENDPUBLISH (use `%% ENDPUBLISH`) i.e. `%%`, followed by a space, followed by
% `ENDPUBLISH`.
% 
% 
%% See Also
%  PUBLISH, HELP, LOOKFOR
%  latex2markdown / livescript2markdown 
%
%
%% Authors
% Mehul Gajwani, Monash University, 2023
%
%
%% TODO
% * Add option to use m2md-this-directory to target another directory (i.e.
% other than the current directory)
% * Consider adding option to remove ToC
% * Review where outputs are produced (relative vs absolute locations)
% * Some potential issues when passing in full hyperlinks - can currently be
% worked around by putting them in code blocks using backticks
%
%
%% ENDPUBLISH



%% Prelims
ip = inputParser;
ip.addOptional('file', [], @(x) isstring(x) || ischar(x) || isempty(x) );
ip.addParameter('texOptions', {"evalCode", false, "showCode", false, "format", "latex"});
ip.addParameter('mdOptions', {});
ip.addParameter('outputDir', '.');
ip.addParameter('texDir', '.');
ip.addParameter('mdDir', 'html');
ip.addParameter('mdFilename', []); % this will be overwritten later
ip.addParameter('deleteTex', false);
ip.addParameter('recursiveSearch', false);
ip.addParameter('guessDefaults', true);
ip.addParameter('addYaml', false);
ip.addParameter('plaintextCode', false);

ip.addParameter('doContents', true);
ip.addParameter('contentsName', 'Contents');
ip.addParameter('contentsDir', '.');

if nargin > 0; ip.parse(file, varargin{:}); else; ip.parse([]); end
file = ip.Results.file;
texOptions = ip.Results.texOptions;
mdOptions = ip.Results.mdOptions;
outputDir = ip.Results.outputDir;
texDir = ip.Results.texDir;
mdDir = ip.Results.mdDir;
if any(strcmp(ip.UsingDefaults, 'mdFilename')); mdFilename = file;
else; mdFilename = ip.Results.mdFilename; end
deleteTex = ip.Results.deleteTex;

contentsName = ip.Results.contentsName;
contentsDir = ip.Results.contentsDir;
addYaml = ip.Results.addYaml;
plaintextCode = ip.Results.plaintextCode;

%% Flag to iterate over whole directory (except Contents.m)
if strcmp(file, "m2md-this-directory") || isempty(file)
    if ip.Results.recursiveSearch; d = dir(fullfile(pwd, "**\*.m")); 
    else; d = dir(fullfile(pwd, "*.m"));  end
    fprintf('Identified %i files\n', length(d));

    %% Consider using Guess defaults (if no argument provided)
    if ip.Results.guessDefaults

        % find directory that already contains files
        % a. get folders (NOTE: NOT recursive)
        f = dir;
        f = f(~ismember({f.name},{'..'}));
        f = f([f.isdir]==1);

        % b. get m filenames
        c = dir("*.m");
        c = {c(:).name};
        c = cellfun(@(x) extractBetween(x,1,strlength(x)-2),c);

        % c. find folders with md files; set folder if it contains more than half
        % the docs
        for ii = 1:length(f)
            current = dir(strcat(f(ii).name, filesep, "*.md"));
            current = {current(:).name};
            if sum(contains(current, c)) > length(c)/2
                mdDir = f(ii).name;
                break;
            end
        end
        fprintf('Outputting files to %s\n', fullfile(mdDir));

        % d. similarly, find folders with tex files and set deleteTex
        deleteTex = true;
        for ii = 1:length(f)
            current = dir(strcat(f(ii).name, filesep, "*.tex"));
            current = {current(:).name};
            if sum(contains(current, c)) > length(c)/2
                texDir = f(ii).name;
                deleteTex = false;
                fprintf('Outputting .tex files to %s\n', fullfile(texDir));
                break;
            end
        end
        if deleteTex; fprintf('Deleting .tex files\n'); end

    end % end guessDefaults

    %% Process each file in current directory
    for ii = 1:length(d)
        if ~strcmp(d(ii).name, "Contents.m")
            m2md( extractBetween(convertCharsToStrings(d(ii).name), 1, strlength(d(ii).name)-2) , ...
                varargin{:} , 'mdDir', mdDir, 'texDir', texDir, 'deleteTex', deleteTex);
        else % if this is the contents file 
            if ip.Results.doContents
                 % mdDir and mdFilename may be called twice here
                m2md("Contents", varargin{:}, "mdDir", contentsDir, "mdFilename", contentsName, 'texDir', texDir, 'deleteTex', deleteTex);
                fprintf('Outputting Contents.m to %s\n', contentsDir);
            end
        end
    end
    
    return;
end % end m2md-this-directory


%% Allow users to change tex output dir, md output dir, or both
usingDefault = @(x) any(contains( ip.UsingDefaults, x ));
inCell = @(a,b) any(cellfun(@(x) isequal(class(x),class(b)) && isequal(x,b) , a));

if ~usingDefault('outputDir')
    if usingDefault('texDir'); texDir = outputDir; end
    if usingDefault('mdDir'); mdDir = outputDir; end
end

% allow user to change tex dir if desired
if ( ~usingDefault('texDir') || ~usingDefault('outputDir') )...
        && ~inCell(texOptions, "outputDir")
    texOptions{end+1} = "outputDir";
    texOptions{end+1} = texDir;
end

% allow user to change md dir and name if desired
if (~usingDefault('mdFilename') || ~usingDefault('mdDir')) ...
        && usingDefault('mdOptions')
    mdOptions{end+1} = "outputfilename";
    mdOptions{end+1} = append(mdDir,filesep,mdFilename);
end


%% Main
texFile = publish(file, texOptions{:});
[texPath, texName] = fileparts(texFile);
mdFile = latex2markdown_mFile(append(texPath, filesep, texName), mdOptions{:});


%% Options
if addYaml
    [~,temp] = fileparts(mdFile);
    writeFrontmatter(mdFile, struct('layout', 'default', 'title', temp));
end

if plaintextCode
    temp = readlines(mdFile);
    temp = replace(temp, 'matlab:Code(Display)', 'matlab');
    fid = fopen(mdFile,'wt');
    fwrite(fid, join(temp, newline));
    fclose(fid);
end

%% deleteTex
if deleteTex
    delete(texFile);
    if length(dir(texPath)) == 2 % folder only contains . and ..
        rmdir(texPath);
    end
end


end % end main











%% Consider using Guess defaults (if no argument provided)
% % % % % if ip.Results.guessDefaults
% % % % % 
% % % % %     % 1. find directory that already contains files
% % % % %     % a. get folders (NOTE: NOT recursive)
% % % % %     f = dir
% % % % %     f = f(~ismember({f.name},{'..'})); 
% % % % %     f = f([f.isdir]==1);
% % % % % 
% % % % %     % b. get m filenames
% % % % %     c = dir("*.m"); 
% % % % %     c = {c(:).name}; 
% % % % %     c = cellfun(@(x) extractBetween(x,1,strlength(x)-2),c);
% % % % % 
% % % % %     % c. find folders with md files; set folder if it contains more than half
% % % % %     % the docs
% % % % %     for ii = 1:length(f)
% % % % %         current = dir(strcat(f(ii).name, filesep, "*.md"));
% % % % %         current = {current(:).name}
% % % % %         if sum(contains(current, c)) > length(c)/2
% % % % %             mdDir = f(ii).name
% % % % %             mdOptions{end+1} = "mdDir";
% % % % %             mdOptions{end+1} = mdDir;
% % % % %             break;
% % % % %         end
% % % % %     end
% % % % % 
% % % % %     % d. similarly, find folders with tex files and set deleteTex
% % % % %     deleteTex = true; 
% % % % %     for ii = 1:length(f)
% % % % %         current = dir(strcat(f(ii).name, filesep, "*.tex"));
% % % % %         current = {current(:).name};
% % % % %         if sum(contains(current, c)) > length(c)/2  
% % % % %             texDir = f(ii).name; 
% % % % %             deleteTex = false; 
% % % % %             texOptions{end+1} = "outputDir"; %#ok<*AGROW> 
% % % % %             texOptions{end+1} = texDir;
% % % % %             break;
% % % % %         end
% % % % %     end
% % % % % 
% % % % % end % end guessDefaults
