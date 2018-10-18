function M = getParallelInfo()
if license('test', 'Distrib_Computing_Toolbox')
	p = gcp('nocreate');
else
	p = [];
end
if isempty(p)
	M = 0;
else
	M = p.NumWorkers;
end
end

