%% Merge multiple struct
%    function sout = structmerge( s1, s2, ..., mode)
% NOTE: If two struct instances of the input have the same field and 'exclude' options is
% not specified, the later will override the value of the former.
function output_struct = structmerge( varargin )
output_struct =struct;
if ischar(varargin{end})
    mode = varargin{end};       % mode is 'override'|'exclude'
    varargin = varargin(1:end-1);
    if ~contains(mode, {'override','exclude'})
        mode = ['override-' mode];
    end
else
    mode = 'override';
end
for i = 1:length(varargin)
    if isempty(varargin{i})
        continue;
    elseif ~isstruct(varargin{i})
        error('error: structmerge: value is not a struct.');
    else
        exist_fields = fieldnames(varargin{i});
        for j = 1:length(exist_fields)
            b_duplicate = isfield(output_struct, exist_fields{j});
            if ~b_duplicate || ~contains(mode, 'exclude')
                output_struct.(exist_fields{j}) = varargin{i}.(exist_fields{j});
            end
            if b_duplicate && contains(mode, 'warning')
                warning('structmerge: duplicate field (<%s> %s).', ...
                    exist_fields{j}, strtok(mode,'-'));
            end
        end
    end
end

end

