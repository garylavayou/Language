function tf = istype(inputArg1,inputArg2)
%ISTYPE Summary of this function goes here
%   Detailed explanation goes here
if ~ischar(inputArg1)
	childtype = class(inputArg1);
else
	childtype = inputArg1;
end
if ~ischar(inputArg2)
	supertype = class(inputArg2);
else
	supertype = inputArg2;
end

if strcmp(childtype, supertype)
    tf = true;
elseif ismember(supertype, superclasses(childtype))
    tf = true;
else
    tf =false;
end

end

