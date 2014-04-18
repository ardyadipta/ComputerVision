function [compareX, compareY] = makeTestPattern(patchWidth, nbits)
	%tau gives value 1 if p(x)<p(y)
	%tau gives value 0 if otherwise
	% I would like to make that the X is near the middle axis of the patch,
	% and Y is randomly distributed
	mid_patch = ceil(patchWidth^2/2);
	
	%initialize compareX and compareY
	compareX = zeros(nbits,1);
	compareY = zeros(nbits,1);

	compareX = round(normrnd(mid_patch,patchWidth, nbits,1));
	compareY = randi(patchWidth^2, nbits,1);
end

