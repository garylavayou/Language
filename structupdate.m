%% Update struct fields
%    function sout = structupdate(st, ss)
%    function sout = structupdate(st, ss, mode)
%					Update fields of |st| with values in |ss|. The |mode| controls the output
%					information.
%    function sout = structupdate(st, ss, fields)
%    function sout = structupdate(st, ss, fields, mode)
%					|fields| specifies which fields in |st| will be updated.
function st = structupdate(st, ss, fields, varargin)
%% 
% see <getstructfields> to set DEBUG information.
global DEBUG;

switch length(varargin)
	case 1
		if ischar(varargin{1})
			mode = varargin{1};
		else
			fields = varargin{1};
		end
	case 2
		fields = varargin{1};
		mode = varargin{2};
end
if ~exist('mode', 'var')
	mode = 'warning';
end
if ~exist('fields', 'var') || isempty(fields)
  fields = fieldnames(st);
end

for i = 1:length(fields)
	if ~isfield(ss, fields{i})
		message = sprintf('Field ''%s'' is not provided.', fields{i});
		switch mode
			case 'warning'
				message = [message(1:end-1), sprintf(', the origin value is ')];
				if ~isempty(DEBUG) && DEBUG
					% Decare the global DEBUG, or set a local DEBUG variable to enable warning.
					message = [message, tocstring(st.(fields{i})), '.' ]; %#ok<AGROW>
					warning(message);
				else
					message = [message, tocstring(st.(fields{i}), 'full'), '.']; %#ok<AGROW>
					cprintf('SystemCommands', 'Warning:[%s] %s\n', calledby, message);
				end
			case 'error'
				error('error: %s', message);
			case 'ignore'
			otherwise
				error('error: unrecognized mode ''%s''', mode);
		end
	elseif isempty(ss.(fields{i}))
		message = sprintf('[%s] Field ''%s'' is empty.', calledby, fields{i});
		if ~isempty(DEBUG) && DEBUG
			error(message); %#ok<SPERR>
		else
			cprintf('SystemCommands', 'Warning:%s\n', message);
		end
	else
		st.(fields{i}) = ss.(fields{i});
	end
end
end

