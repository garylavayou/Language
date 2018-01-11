function new_struct = getstructfields( struct_obj, field_names, action, default_value)
%getstructfields Retrieve fields from struct object.
% |action|:
%    'default': fields that does not exist in |struct_obj| or the field is empty, will be
%           set as a specified default value (deault is 0);
%    'empty': fields that does not exist in |struct_obj| will be set as empty;
%    'ignore': fields that does not exist in |struct_obj| or the field is empty will be
%           ignored;
%    'error': if a requested field is empty or not exist, produce an error.
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

if nargin < 3
    action = '';
end
if contains(action, 'default') && nargin<4
    default_value = 0;
end
if contains(action, 'empty')
    default_value = [];
end
if ischar(field_names)      % to support a single char array (string).
    field_names = {field_names};
end

caller_name = calledby;
new_struct = struct;
for i = 1:length(field_names)
    if isfield(struct_obj, field_names{i})
        if ~isempty(struct_obj.(field_names{i}))
            new_struct.(field_names{i}) = struct_obj.(field_names{i});
            continue;
        end
    end
    if contains(action, 'error')
        if isfield(struct_obj, field_names{i})
            error('%s: field ''%s'' is empty.', caller_name, field_names{i});
        else
            error('%s: field ''%s'' does not exist.', caller_name, field_names{i});
        end
    end
    if nargin >= 3 && contains(action, {'empty', 'default'})
        if iscell(default_value)
            if length(field_names) == 1
                new_struct.(field_names{i}) = default_value;    % assign cell not the cell content.
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
    if ~contains(action, 'ignore')
        if isfield(struct_obj, field_names{i})
            message = sprintf('[%s] field ''%s'' is empty and removed.', caller_name, field_names{i});
        elseif isfield(new_struct, field_names{i})
            value = new_struct.(field_names{i});
            if ischar(value) ||  (isscalar(value) && (isnumeric(value) || islogical(value)))
                val_str = evalc('disp(new_struct.(field_names{i}))');
                message = sprintf('[%s] field ''%s'' does not exist, set as ''%s''.', ...
                    caller_name, field_names{i}, strip(val_str));
            else
                val_str = evalc('disp(new_struct.(field_names{i}))');
                val_str(end) = [];
                message = sprintf('[%s] field ''%s'' does not exist, set as \n%s.', ...
                    caller_name, field_names{i}, val_str);
            end
        else
            message = sprintf('[%s] field ''%s'' does not exist, ignored.', ...
                caller_name, field_names{i});
        end
        if ~isempty(DEBUG) && DEBUG
            warning(message);
        else
            cprintf('SystemCommands', 'Warning: %s\n', message);
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