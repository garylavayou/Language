function new_struct = getstructfields( struct_obj, field_names, action, default_value)
%getstructfields Retrieve fields from struct object.
% |action|:
%    'ignore': fields that does not exist in |struct_obj| will be ignored;
%    'empty': fields that does not exist in |struct_obj| will be set as empty;
%    'default': fields that does not exist in |struct_obj| will be set as a specified
%    default value (deault is 0); 
% multiple actions can be used in combination.
% NOTE: invalid action will be ignored as no such action.
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
            error('error: field ''%s'' is empty.', field_names{i});
        else
            error('error: field ''%s'' does not exist in struct.', field_names{i});
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
            new_struct.(field_names{i}) = default_value;
        end
    end
    if ~contains(action, 'ignore')
        if isfield(struct_obj, field_names{i})
            warning('field ''%s'' is empty and removed.', field_names{i});
        elseif isfield(new_struct, field_names{i})
            if islogical(new_struct.(field_names{i})) ||...
                    isnumeric(new_struct.(field_names{i}))
                warning('field ''%s'' does not exist in struct, set as [%s].', ...
                    field_names{i}, num2str(new_struct.(field_names{i})));
            elseif ischar(new_struct.(field_names{i}))
                warning('field ''%s'' does not exist in struct, set as [%s].', ...
                    field_names{i}, new_struct.(field_names{i}));
            else
                mc = metaclass(new_struct.(field_names{i}));
                warning('field ''%s'' does not exist in struct, set as [%s].', ...
                    field_names{i}, mc.Name);
            end
        else
            warning('field ''%s'' does not exist in struct, ignored.', field_names{i});
        end
    end
end
end