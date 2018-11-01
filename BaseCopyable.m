classdef BaseCopyable < matlab.mixin.Copyable
	%UNTITLED7 Summary of this class goes here
	%   Detailed explanation goes here
	properties (Access = protected)
		isShallowCopyable logical = true;		
		% default is true to enable normal copy in single inherient.
	end
	
end

