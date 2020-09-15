function [mag] = norm_gradient_mag(input)
% input = im2double(input);
% h = (1/331).*[1 4 7 4 1; 4 20 33 20 4; 7 33 55 33 7; 4 20 33 20 4; 1 4 7 4 1 ];
% img_blur = spatial_filter(input, h);
% % figure
% % imshow(img_blur,[]);
out_sobelv = spatial_filter(input, derivative_kernel('sobel','vertical'));
out_sobelh = spatial_filter(input, derivative_kernel('sobel', 'horizontal'));
out_sobel = sqrt((out_sobelv).^2 + (out_sobelh).^2);
%c_stretch_img = im2double(contrast_stretch(double(out_sobel)));
mag = out_sobel/max(out_sobel,[],'all');


T1 = graythresh(mag);
thres = image_threshold(mag, T1);

figure
imshow(mag);
title('Gradient')

end

