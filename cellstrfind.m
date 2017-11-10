%% Find String
% find if |pattern| exists in the sting array |strs|.
% see also _strfind_, _find_.
function tf = cellstrfind(strs, pattern)
tf = false;
for i = 1:length(strs)
    if contains(strs{i}, pattern)
        tf = true;
        break;
    end
end
end