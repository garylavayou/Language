%% Remove fields from structure
% If the specified fields do not exist in the structure, then the fields are ignored.
% See also <rmfields>.
function [ sout ] = rmstructfields( sin , rm_fields)

names = fieldnames(sin);
sout = struct;
for i = 1:length(names)
    if ~contains(names{i}, rm_fields)       % not exact, partial match will pass the exmination.
        sout.(names{i}) = sin.(names{i});
    end
end

end

