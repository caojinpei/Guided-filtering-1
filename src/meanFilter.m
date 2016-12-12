function dest = meanFilter( img, r )

padImg = double(padarray(img, [r, r], 'replicate'));

R = 2*r+1;
F = ones(R,R)/R/R;

dest = filter2(F, padImg);

dest = dest(r+1:r+height, r+1:r+width);

end
