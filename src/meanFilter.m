function dest = meanFilter( img, r )

% % ========== version 1 =============
% tic;
% [height, width] = size(img);
% 
% dest = zeros(height, width);
% 
% % padding
% padImg = double(padarray(img, [r, r], 'replicate'));
% 
% R = (2*r+1)^2;
% for i = r+1:r+height;
%     for j = r+1:r+width;
%         dest(i - r, j - r) = sum(sum(padImg(i-r:i+r, j-r:j+r))) / R;
%     end
% end
% toc;
% % img: 800x1200, r: 16, time: 4.4s

% % ========== system ==============
% tic;
% [height, width] = size(img);
% padImg = double(padarray(img, [r, r], 'replicate'));
% 
% R = 2*r+1;
% F = ones(R,R)/R/R;
% 
% dest = filter2(F, padImg);
% 
% dest = dest(r+1:r+height, r+1:r+width);
% toc;
% % img: 800x1200, r: 16, time: 0.03s

% % ========== version 2 =============
% tic;
% [height, width] = size(img);
% 
% dest = zeros(height, width);
% 
% % padding
% padImg = double(padarray(img, [r, r], 'replicate'));
% 
% R = (2*r+1);
% dest(1, 1) = sum(sum(padImg(1:R, 1:R)));
% for i = r+1:r+height;
%     j = r+1;
%     if i > r+1;
%         dest(i-r, 1) = dest(i-r-1,1) - sum(padImg(i-r-1, j-r:j+r)) + sum(padImg(i+r, j-r:j+r));
%     end
%     for j = r+2:r+width;
%         dest(i-r, j-r) = dest(i-r,j-r-1) - sum(padImg(i-r:i+r, j-r-1)) + sum(padImg(i-r:i+r, j+r));
%     end
% end
% 
% dest = dest ./ (R*R);
% toc;
% % img: 800x1200, r: 16, time: 3.5s

% ============ version 3 =============
[height, width] = size(img);

dest = zeros(height, width);

% padding
padImg = double(padarray(img, [r, r], 'replicate'));

R = (2*r+1)^2;
c = cumsum(cumsum(padImg, 2));

for i = r+1:r+height;
    for j = r+1:r+width;
        if i == r+1;
            x1 = 0;
        else
            x1 = c(i-r-1,j+r);
        end
        if j == r+1;
            x2 = 0;
        else
            x2 = c(i+r,j-r-1);
        end
        if i > r+1 && j > r+1;
            xx = c(i-r-1,j-r-1);
        else
            xx = 0;
        end
        dest(i-r, j-r) = (c(i+r,j+r)-x1-x2+xx) / R;
    end
end
% img: 800x1200, r: 16, time: 0.08s

end
