function strArray = renameStructArrayField(strArray, oldFieldName, newFieldName)
%RENAMESTRUCTFIELD rename field of structure array.
%   See also <renameStructField>.
if ~strcmp(oldFieldName, newFieldName)
    allNames = fieldnames(strArray);
    % Is the user renaming one field to be the name of another field?
    % Remember this.
    isOverwriting = ~isempty(find(strcmp(allNames, newFieldName), 1));
    matchingIndex = find(strcmp(allNames, oldFieldName));
    if ~isempty(matchingIndex)
        allNames{matchingIndex(1)} = newFieldName;
        for i = 1:length(strArray)
            strArray(i).(newFieldName) = strArray(i).(oldFieldName);
        end
        strArray = rmfield(strArray, oldFieldName);
        if (~isOverwriting)
            % Do not attempt to reorder if we've reduced the number
            % of fields.  Bad things will result.  Let it go.
            strArray = orderfields(strArray, allNames);
        end
    end
end