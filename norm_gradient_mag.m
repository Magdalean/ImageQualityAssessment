function [mag] = norm_gradient_mag(input)
% veritical sobel gradient
out_sobelv = spatial_filter(input, derivative_kernel('sobel','vertical'));
% horizontal sobel gradient
out_sobelh = spatial_filter(input, derivative_kernel('sobel', 'horizontal'));
% gradient magnitude 
out_sobel = sqrt((out_sobelv).^2 + (out_sobelh).^2);
% normalized gradient magnitude 
mag = out_sobel/max(out_sobel,[],'all');

% figure
% imshow(mag);
% title('Gradient')

end

