function new_struct = getstructfields( struct_obj, field_names, action, default_value)
%getstructfields Retrieve fields from struct object.
% |action|:
%    'default': fields that does not exist in |struct_obj| or the field is
%						empty, will be set as a specified default value (default is 0);
%    'empty': fields that does not exist in |struct_obj| will be set as empty;
%    'ignore': no warning message will be generated, if a field does
%						not exist in |struct_obj| or a field is empty;
%    'error': if a requested field is empty or not exist, an error is prompted.
% multiple actions can be used in combination.
% NOTE: invalid action will be ignored; 'error' has higher priority than 'ignore'.
%% Debug Control
% To control debug (warning),
%
% # decare the global |DEBUG| variable, ans use it to condition
%    if ~isempty(DEBUG) && DEBUG
%        debugging_code;
%    end
% # temporarily change the value of the global |DEBUG| variable in the caller, as follows,
%
%   global DEBUG;
% 	old_debug = DEBUG;  % DEBUG might be empty.
%   DEBUG = ture;       % to disable debug, set to false
%   ...
%   DEBUG = old_debug;
global DEBUG;
if ~isempty(DEBUG) && DEBUG
    form = 'full';
else
    form = 'concise';
end
if nargin < 3
    action = '';
end
if contains(action, 'default') && nargin<4
    default_value = 0;
end
if contains(action, 'empty')
    default_value = [];
end
if nargin <= 1 || isempty(field_names)
	field_names = fieldnames(struct_obj);
elseif ischar(field_names)      % to support a single char array (string).
    field_names = {field_names};
end

caller_name = calledby;
if isstruct(struct_obj)
	new_struct = struct;
else
	new_struct = Dictionary;
end
for i = 1:length(field_names)
    if isfield(struct_obj, field_names{i})
        if ~isempty(struct_obj.(field_names{i}))
            new_struct.(field_names{i}) = struct_obj.(field_names{i});
            continue;
        end
    end
    if contains(action, 'error')
			if nargin >= 4
				err_msg = default_value;
			else 
				err_msg = '';
			end
        if isfield(struct_obj, field_names{i})
            error('error: field ''%s'' is empty. %s', field_names{i}, err_msg);
        else
            error('error: field ''%s'' does not exist. %s', field_names{i}, err_msg);
        end
    end
    if nargin >= 3 && contains(action, {'empty', 'default'})
        if iscell(default_value)
            if length(field_names) == 1
                new_struct.(field_names{i}) = default_value{1};    % assign cell not the cell content.
            else
                new_struct.(field_names{i}) = default_value{i};
            end
        else
            if length(field_names) == 1
                new_struct.(field_names{i}) = default_value;
            else
                new_struct.(field_names{i}) = default_value(i);
            end
        end
    end
    if ~contains(action, {'ignore', 'silent'})
        if isfield(struct_obj, field_names{i})
            message = sprintf('field ''%s'' is empty and removed.', field_names{i});
        elseif isfield(new_struct, field_names{i})
            message = sprintf('field ''%s'' does not exist, set as %s.', ...
                field_names{i}, tocstring(new_struct.(field_names{i}), form));
        else
            message = sprintf('field ''%s'' does not exist, ignored.', field_names{i});
        end
        if ~isempty(DEBUG) && DEBUG
            warning(message);
        else
            cprintf('SystemCommands', 'Warning:[%s] %s\n', caller_name, message);
        end
    end
end
end

% function str = logi2str(value)
% if value
%     str = 'true';
% else
%     str = 'false';
% end
% end
