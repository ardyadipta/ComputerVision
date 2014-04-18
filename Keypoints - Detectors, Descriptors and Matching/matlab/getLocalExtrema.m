function locs = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r)
	% define patch width. if the keypoints are located in the place
	% where the patch can be outside the border of the image, ignore that keypoint
	patchwidth = 9;
	half_patch = floor(patchwidth/2);
	% setting the mask for local extrema
	mask = zeros(3,3,3);
	mask(:,:,1) = [0 0 0; 0 1 0; 0 0 0];
	mask(:,:,2) = [1 1 1; 1 1 1; 1 1 1];
	mask(:,:,3) = [0 0 0; 0 1 0; 0 0 0];

	%getting local maxima
	maxima = imregionalmax(DoGPyramid, mask);
	%getting local minima
	minima = imregionalmin(DoGPyramid, mask);
	%combine local maxima and minima to get local extrema
	extrema = maxima | minima;

	%define locs matrix
	locs = [];

	%checking the location where the value of extrema is 1,
	%then compare the threshold to the PrincipalCurvature value at that location
	sizeofDoGPyramid = size(DoGPyramid);
	for level =  1:sizeofDoGPyramid(3)
		for y = 1:sizeofDoGPyramid(1)
			for x = 1: sizeofDoGPyramid(2)
				if extrema(y,x,level) == 1 
					%check threshold, if the magnitude of DoGPyramid passes the th_contrast
					%and the principalCurvature does not exceed th_r, put the location in the locs
					if ((abs(DoGPyramid(y,x,level)) > th_contrast) & (PrincipalCurvature(y,x,level) < th_r))& ...
						((x - half_patch > 0) & (x + half_patch < sizeofDoGPyramid(2)))& ...
						((y - half_patch > 0) & (y + half_patch < sizeofDoGPyramid(1)))
						
							locs = [locs ; x y level];

					end
				end
			end
		end
	end
end
