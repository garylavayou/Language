%% Merge multiple struct
%    function sout = structmerge( s1, s2, ..., mode)
% *mode*: 'override', 'exclude', 'warning';
%       'override': replace the former value of the same field;
%       'exclude': reject the later value of the same field;
%       'warning': prompt information for duplicated fields;
% NOTE: If two struct instances have the same field and 'exclude' options
%				is not specified, the later will override the value of the former. 
% Return value: sout is the first input argument if it is a <Dictionary>.
function output_struct = structmerge( varargin )
%% 
% see <getstructfields> to set DEBUG information.
global DEBUG;

output_struct = varargin{1};
if ischar(varargin{end})
    mode = varargin{end};       % mode is 'override'|'exclude'
    varargin = varargin(1:end-1);
    if ~contains(mode, {'override','exclude'})
        mode = ['override-' mode];
    end
else
    mode = 'override';
end
for i = 2:length(varargin)
    if isempty(varargin{i})
        continue;
    elseif ~isstruct(varargin{i}) && ~isa(varargin{i}, 'Dictionary')
        error('error: %s: value is not a struct or Dictionary.', calledby);
    else
        exist_fields = fieldnames(varargin{i});
        for j = 1:length(exist_fields)
            b_duplicate = isfield(output_struct, exist_fields{j});
            if ~b_duplicate || ~contains(mode, 'exclude')
                output_struct.(exist_fields{j}) = varargin{i}.(exist_fields{j});
            end
            if b_duplicate && contains(mode, 'warning')
                message = sprintf('duplicate field (<%s> %s).', ...
                    exist_fields{j}, strtok(mode,'-'));
                if ~isempty(DEBUG) && DEBUG
                    % Decare the global DEBUG, or set a local DEBUG variable to enable warning.
                    warning(message); %#ok<SPWRN>
                else
                    cprintf('SystemCommands', 'Warning: %s\n', message);
                end
            end
        end
    end
end

end

