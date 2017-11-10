%% Create Empty Class Array from Class Name
% creat empty array 

%% Function Prototype
%   function obj = CreatEmpty(classname,n,m,p,...)
%   function obj = CreatEmpty(classname,[n,m,p,...])
% *Input Arguments*
%
% |classname|: a string representation of the class's name.
% |n,m,p,...|: At least one dimension must be zero.
function obj = creatempty(classname, varargin)
class_constructor = str2func(strcat(classname,'.empty'));
obj = class_constructor(varargin{:});
end