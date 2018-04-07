function str_arr = structarray(length, fields)
% create 
if nargin < 2
    error('The fields of the structure array must be specified');
end

str_arr(length).(fields{1}) = [];
for i = 2:numel(fields)
    str_arr(length).(fields{i}) = [];
end

end

