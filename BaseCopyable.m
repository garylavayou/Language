classdef BaseCopyable < matlab.mixin.Copyable
	%UNTITLED7 Summary of this class goes here
	%   Detailed explanation goes here
	properties (Access = protected)
		isShallowCopyable logical = true;		
		% default is true to enable normal copy in single inherient.
	end
	
	% 	methods
	%% To get the memory size of a handle object
	%	(1) you need to know the size of each property;
	% (2) in case that a property is a handle, you need to recusively get the size of that
	%			property. There might be cycle when pefroming recursion, which is difficult to
	%			resolve at the code level;
	% (3) We do not have access to subclass non-public properties;
	%	(4) You can try to convert a class to a struct, then get the memory size of the
	%			struct. The struct includes all property members of the class as fields, without
	%			access limitation.
	%
	% 		function n = Size(this)
	% 			mc = metaclass(this);
	% 			n = 0;
	% 			for i = 1:length(mc.PropertyList)
	% 				d = this.(mc.PropertyList(i).Name);  
	% 				if isa(d, 'BaseCopyable')
	% 					n = n + d.Size();
	% 				else
	% 					s = whos('d');
	% 					n = n + s.bytes;
	% 				end
	% 			end
	% 		end
	% 	end
	
end

