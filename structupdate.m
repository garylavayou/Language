%% Merge multiple struct
%    function sout = structmerge(st, ss)
function st = structupdate(st, ss, mode)
%% 
% see <getstructfields> to set DEBUG information.
global DEBUG;

if nargin <= 2
	mode = 'warning';
end

fields = fieldnames(st);

for i = 1:length(fields)
	if ~isfield(ss, fields{i})
		message = sprintf('[%s]Field ''%s'' is not provided.', calledby, fields{i});
		switch mode
			case 'warning'
				value = st.(fields{i});
				if ischar(value)
					message = strcat(message(1:end-1), ...
						sprintf(', set as default <''%s''>.', value));
				elseif (isscalar(value) && (isnumeric(value) || islogical(value)))
					val_str = evalc('disp(st.(fields{i}))');
					message = strcat(message(1:end-1), ...
						sprintf(', set as default <%s>.', strip(val_str)));
				end
				if ~isempty(DEBUG) && DEBUG
					% Decare the global DEBUG, or set a local DEBUG variable to enable warning.
					warning(message); 
				else
					cprintf('SystemCommands', 'Warning:%s\n', message);
				end
			case 'error'
				error('error: %s', message);
			case 'ignore'
			otherwise
				error('error: unrecognized mode ''%s''', mode);
		end
	else
		st.(fields{i}) = ss.(fields{i});
	end
end
end

