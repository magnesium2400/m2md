function [str, idxLiteral] = processLiteralOutput_mFile(str)
% Copyright 2020 The MathWorks, Inc.

%% MATLAB Code
% Latex: 
% \begin{matlabcode}(code)\end{matlabcode}
% \begin{verbatim}(code)\end{verbatim}
% \begin{lstlisting}(code)\end{lstlisting}
%
% Markdown
% ```matlab:MATLAB Code
% （code）
%```
%% Literal Outputs
% Latex: 
% \begin{matlaboutput}(output)\end{matlaboutput}
%
% Markdown
% ```text:Output
%  (output)
% ```
% Note: Other outputs (matlabsymbolicoutout, matlabtableoutput)
% will be processed in processDocumentOutput.m

% % % % % % % % added to fix appearance of certain characters % % % % % % % % %
str = replace(str,"\_","_");
str = replace(str,"\{","{");
str = replace(str,"\}","}");
str = replace(str,"\^{}","^");
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 



idx_lstlisting = startsWithSpaced(str,"\\begin{lstlisting}");
idx_verbatim = startsWithSpaced(str,"\\begin{verbatim}");
idx_matlabcode = startsWithSpaced(str,"\\begin{matlabcode}");
idx_matlaboutput = startsWithSpaced(str,"\\begin{matlaboutput}");

idxLiteral = idx_lstlisting | idx_verbatim | idx_matlabcode | idx_matlaboutput;

str(idx_lstlisting) = newline + "```matlab:Code(Display)" + newline + extractBetween(str(idx_lstlisting),...
    "\begin{lstlisting}","\end{lstlisting}") + newline + "```" + newline;
str(idx_verbatim) = newline + "```matlab:Code(Display)" + newline + extractBetween(str(idx_verbatim),...
    "\begin{verbatim}","\end{verbatim}") + newline + "```" + newline;
str(idx_matlabcode) = newline + "```matlab:Code" + newline + extractBetween(str(idx_matlabcode),...
    "\begin{matlabcode}","\end{matlabcode}") + newline + "```" + newline;
str(idx_matlaboutput) = newline + "```text:Output" + newline + extractBetween(str(idx_matlaboutput),...
    "\begin{matlaboutput}","\end{matlaboutput}") + newline + "```" + newline;

end % end main

%%
function str_out = startsWithSpaced(str, regexIn)
temp = regexp(str,"\s{0,}"+regexIn);
for ii = 1:length(temp); str_out(ii) = isequal(temp{ii}, 1); end %#ok<AGROW> 
end