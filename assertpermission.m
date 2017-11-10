%% Asser Access Permission
% Assert if the caller if the current function has access permission to the target class.
% This function is utilized by _subsasgn_ and _subsref_ to implement access control.
%
% |getset|: can only be set to 'get' or 'set'. If the |member| is a method, then this argument
%      should not be supplied.
function assertpermission(targetclass, member, getset)
info = meta.class.fromName(targetclass);
member_info = info.PropertyList;
% determine if |member| is a property's name, and inquire the acess permission
[tf, idx] = ismember(member, {member_info.Name});
if tf
    switch getset
        case 'get'
            access_perm = member_info(idx).GetAccess; 
        case 'set'
            access_perm = member_info(idx).SetAccess; 
        otherwise
            error('error: invalid value for getset.');
    end
else
    % inquire the method's access permission.
    member_info = info.MethodList;
    [tf, idx] = ismember(member, {member_info.Name});
    if tf
        if nargin >= 3 && strcmpi(getset, 'set')
            error('error: %s is a method, no set attributes.', member);
        end
        access_perm = member_info(idx).Access;
    else
        error('error: %s is not a member of %s.', member, targetclass);
    end
end
caller = calledby(2);
caller = strtok(caller, '.');
tf = true;
if iscell(access_perm)
    % Access List
    access_list = [access_perm{:}];
    if ~(ismember(caller, {access_list.Name}) || ...
            (ismember(info.Name, {access_list.Name}) && ...
            ismember(info.Name, superclasses(caller))))
        % When caller is a normal function, superclasses returns an empty array.
        tf = false;
    end
else
    % Access modifer
    switch access_perm
        case 'public'
        case 'private'
            if ~strcmp(caller, targetclass)
                tf = false;
            end
        case 'protected'
            if ~(strcmp(caller, targetclass) || ...
                    ismember(targetclass, superclasses(caller)))
                tf = false;
            end
    end
end
if ~tf
    error('error: No permission to access %s.%s from %s.', ...
        targetclass,member_info(idx).Name, caller);
end
end
