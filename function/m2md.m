function [mdFile, texFile] = m2md(file, varargin)
%% m2md Convert MATLAB .m docstring/help to Markdown
% Note: this README was generated using `m2md` and uses syntax dependent on
% MATLAB(R)'s PUBLISH function. However, it *requires the addition of the
% keyphrase `%% ENDPUBLISH` after the help/docstring to function*. See the help
% for the PUBLISH function and the associated Topic pages for more information
% on styling. For example, start lines with 1 space to show regular text; 2
% spaces for monospaced text; and 3 spaces for actual code. As much as possible,
% compatibility with both PUBLISH and HELP was maintained. This code is
% distributed as-is, but is accepting improvements (at least in 2023).
%% Syntax
%   m2md(file)
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
%   m2md("m2md", 'texDir', 'tmp', 'mdDir', '.', 'mdFilename', 'README', 'deleteTex', true);
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
%  texOptions - Options to pass through to PUBLISH (cell array) 
%  Name-Value arguments to be passed through when calling PUBLISH. The default
%  bevahiour is to set the format to latex and turn off the display and
%  evaluation of code. These can be changed if desired, but is likely to
%  significantly harm performance. See the Name-Value Arguemnts of PUBLISH for
%  more information.
%   
%  mdOptions - Options to pass through to LATEX2MARKDOWN (cell array)
%  Name-Value arguments to be passed through when calling LATEX2MARKDOWN. Note
%  that there is currently *NO* option to turn off the Table of Contents - this
%  is autogenerated by PUBLISH. See the Instructions/docs for LATEX2MARKDOWN /
%  LIVESCRIPT2MARKDOWN for more information.   
%   
%  outputDir - Directory to create the tex and md files (string | character vector) 
%  Output folder to which the tex and md files are saved. If no folder is
%  specified, these will be output to the default specified by PUBLISH,
%  `./html`.
%  
%  texDir - Directory to create the tex file only (string | character vector)
%  Output folder to which the tex file only is saved.
%  
%  mdDir - Directory to create the md file only (string | character vector)
%  Output folder to which the md file only is saved.
%
%  mdFilename - Name of the md file (string | character vector)
%  Output file name to which the md file is saved. 
%
%  deleteTex - Flag to delete tex file (false (deafult) | true)
%  Whether to delete the intermediary tex file, specified as `true` or `false`.
%  If the tex file is deleted and its parent folder is empty, the parent folder
%  will then be deleted too.
%
%
%% Output Arguments
%  mdFile - Relative path to .md file (string | character vector)
%  The output filepath as generated by LATEX2MARKDOWN.
%
%  texFile - Full path to .tex file (character vector | string)
%  The output filepath as generated by PUBLISH.
%
%
%% Tips
% - In order to demarcate the end of the docstring: create a section entitled
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

%% ENDPUBLISH

%% TODO
% - Consider adding option to remove ToC


%% Prelims
ip = inputParser;
ip.addRequired('file');
ip.addOptional('texOptions', {"evalCode", false, "showCode", false, "format", "latex"});
ip.addOptional('mdOptions', {});
ip.addOptional('outputDir', '.');
ip.addOptional('texDir', '.');
ip.addOptional('mdDir', 'html');
ip.addOptional('mdFilename', file);
ip.addOptional('deleteTex', false);


ip.parse(file, varargin{:});
file = ip.Results.file;
texOptions = ip.Results.texOptions;
mdOptions = ip.Results.mdOptions;
outputDir = ip.Results.outputDir;
texDir = ip.Results.texDir;
mdDir = ip.Results.mdDir;
mdFilename = ip.Results.mdFilename;


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
if ~usingDefault(mdFilename) && usingDefault('mdOptions')
    mdOptions{end+1} = "outputfilename";
    mdOptions{end+1} = append(mdDir,filesep,mdFilename);
end


%% Code
texFile = publish(file, texOptions{:} );
[texPath, texName] = fileparts(texFile);
mdFile = latex2markdown_mFile(append(texPath, filesep, texName), mdOptions{:});

if ip.Results.deleteTex
    delete(texFile);
    if length(dir(texPath)) == 2 % folder only contains . and ..
        rmdir(texPath);
    end
end


end
