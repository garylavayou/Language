%% Set default value for structure
% If a field from the source struct does not exist in the target struct, the field in the
% target will be set with the source's value.
%		s = setdefault(s, s_def)
%		s = setdefault(s, s_def, fields)
%   s = setdefault(s, s_def, fields, mode)
%			|s| is an object of <struct> or <Dictionary>. If s is a <Dictioanry>, the changes
%			will be maintained in the input argument |s|.
% NOTE: setdefault does not produce warning if the |s_def| has empty fields or lacks
% fields that exist in |s|. See also <structupdate> that explictly update each fields of
% |s|.
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
			if DEBUG
				warning('%s set to %s', message, tocstring(s_def.(fields{i}), 'full') );
			else
				cprintf('SystemCommands', 'Warning:[%s] %s\n', calledby, ...
					sprintf('%s set to %s.', message, tocstring(s_def.(fields{i}))) );
			end
		end
	end
end

end

