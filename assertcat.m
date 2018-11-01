function b_concat = assertcat(elements, ifwarning)
if nargin <= 1
	ifwarning = false;
end
b_concat = true;
if isscalar(elements) && isempty(elements{1})
	b_concat = false;
	return;
end
for i_ = 1:numel(elements)
	if isempty(elements{i_}) || ~isscalar(elements{i_}) || ischar(elements{i_}) || istable(elements{i_})
		% isscalar([]) = false
		b_concat = false;
		if ifwarning && ~isscalar(elements)
			% If the output argument are not concatenatable, an warning is prompted.
			warning('[%s] the results are not concatenatable, convert to cell array.', calledby);
		end
		break;
	end
end
end