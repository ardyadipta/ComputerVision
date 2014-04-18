function [matches] = briefMatch(desc1, desc2, ratio)

	matches = [];
	D = pdist2(desc1,desc2,'hamming');
	%sorting for each row
	Dsize = size(D);
	for i = 1:Dsize(1)
		[B, Ix] = sort(D(i,:));
		if (B(1)/B(2)) < ratio
			matches = [matches ; i Ix(1)];
		end
	end
end
