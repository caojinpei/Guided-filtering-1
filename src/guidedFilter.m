function q = guidedFilter( p, I, r, epss )

% convert to [0, 1]
p = double(p) / 255;
I = double(I) / 255;

meanI = meanFilter(I, r);
meanII = meanFilter(I .* I, r);
varI = meanII - meanI .* meanI;

meanP = meanFilter(p, r);
meanIP = meanFilter(I .* p, r);
covIP = meanIP - meanI .* meanP;
a = covIP ./ (varI + epss);
b = meanP - a .* meanI;

meanA = meanFilter(a, r);
meanB = meanFilter(b, r);

q = meanA .* I + meanB;

end
