function [correct_matches, im_rot, desc_rot, locs_rot, matches_rot] = briefRotTest(im)
	im1 = im;
	im_rot = cell(35, 1);
	[locs, desc] = brief(im);
	locs_rot = cell(35,1);
	desc_rot = cell(35,1);
	matches_rot = cell(35,1);
	ratio = 0.5;
	correct_matches = [];

	for i = 1:35
		im_rot{i} = imrotate(im, 10*i);
		[locs_rot{i}, desc_rot{i}] = brief(im_rot{i});
		[matches_rot{i}] = briefMatch(desc, desc_rot{i}, ratio);
		correct_matches = [correct_matches ; i*10, size(matches_rot{i},1)];
	end

	plot(correct_matches(:,1), correct_matches(:,2));
end


