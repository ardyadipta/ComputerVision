function [locs, desc] = brief(im)
	load testPattern.mat;
	[locs, GaussianPyramid] = DoGdetector(im, sigma0, k, levels,th_contrast, th_r);
	[locs,desc] = computeBrief(im, locs, levels, compareX, compareY);