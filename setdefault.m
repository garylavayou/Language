function s = setdefault(s, s_def)
global DEBUG;
fields = fieldnames(s_def);

for i = 1:length(fields)
	if isfield(s, fields{i}) && ~isempty(s.(fields{i}))
		continue;
	else
		if ~isfield(s, fields{i}) 
			message = sprintf('Field ''%s'' not exist,', fields{i});
		else 
			message = sprintf('Field ''%s'' is empty,', fields{i});
		end
		s.(fields{i}) = s_def.(fields{i});
		if ~isempty(DEBUG) && DEBUG
			warning('%s set to %s', message, tocstring(s_def.(fields{i}), 'full') );
		else
			cprintf('SystemCommands', 'Warning:[%s] %s\n', calledby, ...
				sprintf('%s set to %s.', message, tocstring(s_def.(fields{i}))) );
		end
	end
end

end

