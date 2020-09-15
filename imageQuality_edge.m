function [value] = imageQuality_edge(image,type)
%IMAGEQUALITY_EDGE This function will accept a volume of data array.
%   Please enter the image type in quotation  (case insensitive)
%   Accepted Image types: 'brain' or 'lung'
%   It takes the middle slice of the image and then procceeds to see the
%   change in the key indicators: 
%   Continuity. 
%   Change in Edge Width.
%   Change in Average Frequency.
%   ** This is a weighted metric ** 



Dimension = ndims(image);
% Ensures the input is a volume.

if Dimension == 3
    len = round(length(image(1,1,:)));
    mid = round(len/2);
    image = image(:,:,mid);

% remove noise from images
denoised_image = medfilt(image,5,5);
% find the normalized gradient magnitude 
norm_grad = norm_gradient_mag(denoised_image);
%% compare with sharpened image 
% unsharp masking 
% h = (1/331).*[1 4 7 4 1; 4 20 33 20 4; 7 33 55 33 7; 4 20 33 20 4; 1 4 7 4 1 ];
% img_blur = spatial_filter(denoised_image, h);
% mask = denoised_image - img_blur;
% enhanced = denoised_image + mask; 
% c_stretch_enhanced = c_stretch_gradient_mag(enhanced);

%sharpern with matlab function 
matlab_sharp = imsharpen(denoised_image,'Radius',2,'Amount',2);
% find the normalized gradient magnitude of sharpened image
norm_enhanced = norm_gradient_mag(matlab_sharp);
%fft2 of normalized gradient
% orig = abs(1+log(fft2(norm_grad)));
%fft2 of stretched normalized gradient
% en = abs(1+log(fft2(norm_enhanced)));


% average frequency content of the orginal normalized gradient
mean_orig = mean(abs(1+log(fft2(norm_grad))),'all');
% average frequency content of the stretched normalized gradient
mean_enhanced = mean(abs(1+log(fft2(norm_enhanced))),'all');
freq_change = abs((mean_enhanced-mean_orig)/mean_orig);
freq_metric = 1- freq_change;

% figure
% imagesc(abs(fftshift(orig)))
% title('Gradient FFT2 (orig)')
% colorbar
% figure
% imagesc(abs(fftshift(en)))
% title('Gradient FFT2 (sharpened)')
% colorbar

% Determine Otsu Threshold
T1 = graythresh(norm_grad);
T2 = graythresh(norm_enhanced);

% threshold images
thresholded_img1 = image_threshold(norm_grad, T1);
thresholded_img2 = image_threshold(norm_enhanced, T2);

%% Find length of the edges
% find the skeleton of the thresholded images 
skeleton = bwmorph(thresholded_img1,'skel',Inf);
skeleton2 = bwmorph(thresholded_img2,'skel',Inf);
% find the area of the thresholded images
area= bwarea(thresholded_img1); 
area2= bwarea(thresholded_img2); 
% find the length of the skeletons
length_edge = sum(skeleton,'all');
length_edge2 = sum(skeleton2,'all');
% find the width of edges
avgwidth = area/length_edge;
avgwidth2 = area2/length_edge2;
%measure the width change
% width_change should increase with more noisey input
width_change = abs((avgwidth2-avgwidth)/avgwidth);
width_metric = 1 - width_change;

%% Find how continuous the edges are
continuity = Continuous_Metric(image,type);
%% assign metric to brain or lung image 
% a weighted average of key indicators is returned
if strcmpi(type,'brain')
    value = (width_metric+2*continuity+freq_change)/4;
    value = round(value,2);
elseif strcmpi(type,'lung')
    value = (2*continuity+freq_change)/3;
    value = round(value,2);
end

else
    disp('ERROR, ENTER VOLUME DATA')
    value = 0;


end

