%% Set default value for structure
%		s = setdefault(s, s_def)
%		s = setdefault(s, s_def, fields)
%   s = setdefault(s, s_def, fields, mode)
function s = setdefault(s, s_def, varargin)
global DEBUG;
if nargin <= 2
	fields = fieldnames(s_def);
	mode = 'silent';		% {silent|warning}
elseif nargin <= 3
	if ischar(varargin{1})
		fields = fieldnames(s_def);
		mode = varargin{1};
	else
		fields = varargin{1};
		mode = 'silent';		% {silent|warning}
	end
else
	fields = varargin{1};
	mode = varargin{2};
end

for i = 1:length(fields)
	if isfield(s, fields{i}) && ~isempty(s.(fields{i}))
		continue;
	else
		s.(fields{i}) = s_def.(fields{i});
		if strcmpi(mode, 'warning')
			if ~isfield(s, fields{i})
				message = sprintf('Field ''%s'' not exist,', fields{i});
			else
				message = sprintf('Field ''%s'' is empty,', fields{i});
			end
			if ~isempty(DEBUG) && DEBUG
				warning('%s set to %s', message, tocstring(s_def.(fields{i}), 'full') );
			else
				cprintf('SystemCommands', 'Warning:[%s] %s\n', calledby, ...
					sprintf('%s set to %s.', message, tocstring(s_def.(fields{i}))) );
			end
		end
	end
end

end

