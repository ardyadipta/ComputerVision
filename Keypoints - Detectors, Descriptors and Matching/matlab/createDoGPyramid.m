function [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels)
	levelsize = length(levels);
	sizeGP = size(GaussianPyramid);
	DoGPyramid = zeros([sizeGP(1),sizeGP(2),length(levels)-1]);
	DoGLevels = zeros(1,length(levels)-1);
	
	for h = 1:(length(levels)-1)
		DoGPyramid(:,:,h) = GaussianPyramid(:,:,h) - GaussianPyramid(:,:,h+1);
		DoGLevels(1,h) = h-1;
	end



