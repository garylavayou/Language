function [ sout ] = rmstructfields( sin , rm_fields)

names = fieldnames(sin);
for i = 1:length(names)
    if ~contains(names{i}, rm_fields)       % not exact, partial match will pass the exmination.
        sout.(names{i}) = sin.(names{i});
    end
end

end

