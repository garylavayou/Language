function [out, line] = calledby(depth, bConcise)
% out = calledby(func_name)
% OVERVIEW
%     Queries the source of a function call, with variable depth, returning
%     the calling function's name.
% 
% FORMS
%     out = calledby
%     out = calledby(depth)
%			out = calledby(depth, bConcise)
% 
% DESCRIPTION
%     out = calledby
%       Returns the name of the calling function
%     out = calledby(depth)
%       Returns the name of the calling function at depth depth
%			out = calledby(depth, bConcise)
%				Returns the concise name of the calling function at depth depth, if
%				bConcise=true.
%
% INPUTS
%     depth - Depth of calling function to search. 
%				0 = current function,
%				1 = calling function (default), etc..
% 
% OUTPUTS
%     out - Name of calling function or queried function. Returns 'workspace' if
%     called from base workspace
% 
% SEE ALSO
%     is_calledby
%     http://www.mathworks.com/matlabcentral/fileexchange/51280-is-calledby-func-name-

    if nargin < 1; depth = [];end
    if isempty(depth); depth = 1; end

    ST = dbstack;
    
    % Add dummy data for base workspace
    ST(end+1)=ST(end);
    ST(end).name = 'workspace';
    ST(end).file = 'workspace';
    ST(end).line = 1;
    
  
    if depth + 2 > length(ST)   % Add 2, one for callby and one to switch starting depth to 0
        error('Depth parameter exceeds actual depth of function calls.');
        %if depth + 2 > length(ST); depth = length(ST) - 2; end     % If depth is too deep, automatically rescale.
    end

    out = ST(depth+2).name;

		%% MODIFIED
		if nargin >= 2 && bConcise
			out = split(out, '.');
			out = out{end};
		else
			tempout = split(out, '.');
			if length(tempout) == 2 && isequal(tempout{1},tempout{2})
				out = tempout{1};
			end
		end
		if nargout >= 2
			line = ST(depth+2).line;
		end
end
