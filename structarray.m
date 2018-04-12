%% Create structure array
%   str_arr = structarray(length, fields)
%       Create empty array with |fields|.
%   str_arr = structarray(length, field1, value1, field2, value2, ...)
%       Create array with fiels |field1, field2, ...|, all the elements are initialized
%       with the same value |value1, value2, ...|.
function str_arr = structarray(length, varargin)
if nargin < 2
    error('The fields of the structure array must be specified');
end

if nargin == 2
    str_arr.(varargin{1}{1}) = [];
    for i = 2:numel(varargin{1})
        str_arr.(varargin{1}{i}) = [];
    end
else
    str_arr = struct(varargin{:});
end

if length > 1
    str_arr = repmat(str_arr, length, 1);
end

end

