function q = guidedFilter( p, I, r, epss )

% convert to [0, 1]
p = double(p) / 255;
I = double(I) / 255;

meanI = meanFilter(I, r);
meanP = meanFilter(p, r);
corrI = meanFilter(I .* I, r);
corrIP = meanFilter(I .* p, r);

varI = corrI - meanI .* meanI;
covIP = corrIP - meanI .* meanP;
a = covIP ./ (varI + epss);
b = meanP - a .* meanI;

meanA = meanFilter(a, r);
meanB = meanFilter(b, r);

q = meanA .* I + meanB;

end
