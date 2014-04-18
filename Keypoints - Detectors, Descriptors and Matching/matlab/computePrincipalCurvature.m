function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
	sizeofDoG = size(DoGPyramid);
	PrincipalCurvature  = zeros(sizeofDoG);
	% getting the Dx, Dy, Dxx, Dxy, and Dyy for making the Hessian Matrix
	for i = 1:sizeofDoG(3)
		[Dx, Dy] = gradient(DoGPyramid(:,:,i));
		[Dxx, Dxy] = gradient(Dx);
		[Dxy, Dyy] = gradient(Dy);

		%making hessian for each pixel
		for x = 1:sizeofDoG(1)
			for y = 1:sizeofDoG(2)
				H = [Dxx(x,y) Dxy(x,y); Dxy(x,y) Dyy(x,y)];
				%calculate the curvative ratio
				R = (trace(H))^2/ det(H);
				PrincipalCurvature(x,y,i) = R;
			end
		end
	end
end


