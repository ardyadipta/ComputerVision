function [locs,desc] = computeBrief(im, locs, levels, compareX, compareY)
	%first column of locs is x, second column is y
	%get patches from the locs
	k = sqrt(2);
	sigma0 = 1;
	nbits = length(compareX);
	GaussianPyramid = createGaussianPyramid(im, sigma0, k, levels);
	patch_width = 9;
	center_patch = ceil(patch_width/2);
	size_locs= size(locs);
	patch = cell(size_locs(1),1);
	desc = zeros(size_locs(1),size(compareX));
	%keypoints are centers of the patches

	%the value of the pixel density of the image at certain pixel is im(y,x)
	%make patches from each keypoint
	for i = 1:size_locs(1)
		patch{i} = zeros(patch_width); %make the patch of 9x9 pixels
		center_patch_pixel = GaussianPyramid(locs(i,2),locs(i,1),locs(i,3)); %while the gaussianpyramid is (y,x, level)
		patch{i}(center_patch, center_patch) = center_patch_pixel; % fill the value of pixel at the central patch
		for patch_x = 1: patch_width
			for patch_y = 1: patch_width
				patch{i}(patch_y, patch_x) = GaussianPyramid(locs(i,2)-center_patch+patch_y,locs(i,1)-center_patch+patch_x,locs(i,3));
				
			end
		end

		for j = 1:nbits
			if patch{i}(compareX(j)) < patch{i}(compareY(j))
				desc(i,nbits+1-j) = 1;
			else
				desc(i,nbits+1-j) = 0;
			end
		end
	end

	locs = locs;