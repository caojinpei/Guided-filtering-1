function q = guidedFilterColor( p, I, r, eps )

% apply filter to each channel
R = guidedFilter(p(:,:,1), I(:,:,1), r, eps);
G = guidedFilter(p(:,:,2), I(:,:,2), r, eps);
B = guidedFilter(p(:,:,3), I(:,:,3), r, eps);

q = cat(3, R, G, B);

end
