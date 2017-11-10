function tf = iscompatible( childtype, supertype )
%ISCOMPATIBLE Test compatible classes.
%   tf = iscompatible( childtype, supertype ) returns true if childtype is equal to
%   supertype or supertype is a superclass of childtype.
if strcmp(childtype, supertype)
    tf = true;
elseif ismember(supertype, superclasses(childtype))
    tf = true;
else
    tf =false;
end

end

