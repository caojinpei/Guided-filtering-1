function q = fastGuidedFilter( p, I, r, epss, s )

% convert to [0, 1]
p = double(p) / 255;
I = double(I) / 255;

subI = imresize(I, 1/s, 'nearest');
subP = imresize(p, 1/s, 'nearest');
subR = r / s;

meanI = meanFilter(subI, subR);
meanP = meanFilter(subP, subR);
corrI = meanFilter(subI .* subI, subR);
corrIP = meanFilter(subI .* subP, subR);

varI = corrI - meanI .* meanI;
covIP = corrIP - meanI .* meanP;

a = covIP ./ (varI + epss);
b = meanP - a .* meanI;

meanA = meanFilter(a, subR);
meanB = meanFilter(b, subR);

meanA = imresize(meanA, [size(I, 1), size(I, 2)], 'bilinear');
meanB = imresize(meanB, [size(I, 1), size(I, 2)], 'bilinear');

q = meanA .* I + meanB;

end
