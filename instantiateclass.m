%% Create Class Instance from Class Name

%% Function Prototype
%   function obj = InstantiateClass( classname, arg1, arg2, ...)
%
% *Input Arguments*
%
% |classname|: a string representation of the class's name.
%
% |arg1,arg2,...|: arguments pass to the class's constructor.
function obj = instantiateclass( classname, varargin )
try
    obj = feval( classname, varargin{:});
    %     obj = eval( strcat(classname, '(varargin{:})') );
    %     class_constructor = str2func(classname);
    %     obj = class_constructor(varargin{:});
catch ME
    if strcmp(ME.identifier, 'MATLAB:minrhs')
        obj = creatempty(classname);
    else
        rethrow(ME);
    end
end
end

