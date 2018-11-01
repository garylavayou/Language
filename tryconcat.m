function out = tryconcat(elements, dims, b_concat)
if b_concat
	% try concatation
	try
		elements = [elements{:}];
		if isempty(elements)
			out = [];
		else
			out = reshape(elements, dims);
		end
	catch exception %#ok<NASGU>
		out = reshape(elements, dims);
	end
else
	if isscalar(elements)
		if isempty(elements{1})
			out = [];
		else
			out = elements{1};
		end
	else
		out = reshape(elements, dims); % -> reshape([], 0, 0) = [];
	end
end
end