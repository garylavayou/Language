function d = getdigit(nint, i)
if i<=0 
    error('error: i should be postive integer.');
end
if nint < 0
    error('error: nint should be non-negative integer.');
end
if i>20 || nint > intmax('uint64')
    warning('argument is too large.');
end
d = floor(mod(nint,10^(i))/10^(i-1));
end

