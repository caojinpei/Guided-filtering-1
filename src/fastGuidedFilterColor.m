function q = fastGuidedFilterColor( p, I, r, eps, s )

% apply filter to each channel
R = fastGuidedFilter(p(:,:,1), I(:,:,1), r, eps, s);
G = fastGuidedFilter(p(:,:,2), I(:,:,2), r, eps, s);
B = fastGuidedFilter(p(:,:,3), I(:,:,3), r, eps, s);

q = cat(3, R, G, B);

end
