function [value] = delta_freq(input)
%   DELTA_FREQ: Returns the change in median frequency.

norm_input = input/(max(input,[],'all'));
% Comparison with the denoised image 
medfilt_img = medfilt(norm_input,5,5); 

% avg freq component 
mean_freqmed = mean(abs(1+log(fft2(medfilt_img))),'all');
mean_freqorig = mean(abs(1+log(fft2(norm_input))),'all');

% LOG OF FREQUENCY WAS USED TO MEASURE SMALL CHANGE IN FREQUENCY. 
freq_med = abs(1+log(fft2(medfilt_img)));
freq_orig = abs(1+log(fft2(norm_input)));

% figure
% imagesc(abs(fftshift(freq_med)))
% title('Median Filtered')
% colorbar
% figure
% imagesc(abs(fftshift(freq_orig)))
% title('Original')
% colorbar

% percent difference
percent_change= abs((mean_freqmed-mean_freqorig)/mean_freqorig);

%Value returned is 1 - the change, because a higher change in mean frequency
% shows a lower quality. 

value = 1-percent_change;

end

