function str = tocstring(obj, form)
if nargin <= 1
	form = 'concise';
end
assert(contains(form,{'concise', 'full'}, 'IgnoreCase', true));
if ischar(obj) && isrow(obj)
	str = sprintf('<''%s''>', obj);
elseif isstring(obj) && isscalar(obj)
	str = obj.char;
elseif isenum(obj)
	if isscalar(obj)
		str = ['<', obj.char, '>'];
	else
		error('unhandled type.');
	end
elseif islogical(obj)
	if obj
		str = '<true>';
	else
		str = '<false>';
	end
elseif isnumeric(obj)
	if isscalar(obj)
		str = ['<', num2str(obj), '>'];
	elseif isrow(obj)
		str = ['<', strip(sprintf('\t%g',obj)), '>'];
	end
end
if exist('str', 'var')
	return;
else
	out = split(strip(evalc('display(obj)')), newline);
	if strcmpi(form, 'full')
		str = [newline, strjoin(out(3:end), newline)];
	else
		if isstruct(obj)
			str = strip(out{3});
			fields = fieldnames(obj);
			disp_len = min(length(fields), 3);
			str = [str, '{''', strjoin(fields, ''', ''')];
			if length(fields) > disp_len
				str = [str, '...'];
			end
			str = [str, '''}'];
		elseif istable(obj)
			str = strip(out{3});
			fields = obj.Properties.VariableNames;
			disp_len = min(length(fields), 3);
			str = [str, 'with Variables {''', strjoin(fields, ''', ''')];
			if length(fields) > disp_len
				str = [str, '...'];
			end
			str = [str, '''}'];
		elseif iscell(obj)
			str = strip(out{3});
		elseif ismatrix(obj)
			dims = join(string(num2str((size(obj))')).strip(), 'x');
			type = class(obj);
			str = sprintf('%s <a href="matlab:helpPopup %s" style="font-weight:bold">%s</a> array', ...
				dims, type, type);
		else
			str = [newline, strjoin(out(3:end), newline), newline];
			warning('unhandled type.');
		end
	end
end
end