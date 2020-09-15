function [value] = imageQuality_contrast(image,type)
%IMAGEQUALITY_CONTRAST This function will accept a volume of data array.
%   Please enter the image type in quotation  (case insensitive)
%   Accepted Image types: 'brain' or 'lung'
%   It takes the middle slice of the image and then procceeds to see the
%   change in the key indicators: 
%   Number of Peaks.
%   Width to Peak Ratio.
%   Number of Hight Contrast Areas.
%   ** This is a weighted metric ** 



Dimension = ndims(image);
% Ensures the input is a volume.

if Dimension == 3
    len = round(length(image(1,1,:)));
    mid = round(len/2);
    image = image(:,:,mid);

[bins, freq] = intensityHistogram(double(image));
% Averaging the Lung Histogram
% This is done to make sure the real peaks are detected
% Peak detection was less accurate before averaging
freq2 = freq;
if strcmp(type,'lung')
    for i = 1:(length(freq)-5)
        freq2(i)= mean(freq(i:i+5));
    end
end

% contrast stretch the image 
cstretch = double(contrast_stretch_proj(image));
% figure
% imshow(cstretch,[]);
% title('CONTRAST STRETCHED IMAGE');

% find the high contrast areas 
HC_stretched = var_metric(cstretch);
HC_input = var_metric(image);
percent_change = (HC_stretched - HC_input)/HC_input;
ratio = 1 - percent_change;

% determine if the desired number of peaks are found 
numpeaks = peakdet(image,type);
if strcmpi(type,'brain')
    if numpeaks == 3
        peak_val = 1;
    else 
        peak_val = 0;
    end
elseif strcmpi(type,'lung')
    if numpeaks == 4
        peak_val = 1;
    else 
        peak_val = 0;
    end
    
end

if strcmp(type,'brain')
    %figure
    [pks,locs,w,p]= findpeaks(freq2,bins,'MinPeakDistance', 100,'MinPeakProminence', 100,'Annotate','extents','WidthReference','halfprom');
    findpeaks(freq2,bins,'MinPeakProminence', 100,'Annotate','extents','WidthReference','halfprom')
    %title('Signal Peak Widths - Inputs')
elseif strcmp(type,'lung')
    %figure
    [pks,locs,w,p]= findpeaks(freq2,bins,'MinPeakDistance', 100,'MinPeakProminence', 100,'Annotate','extents','WidthReference','halfprom');
    findpeaks(freq2,bins,'MinPeakDistance', 100,'MinPeakProminence', 100,'Annotate','extents','WidthReference','halfprom')
    %title('Signal Peak Widths - Inputs')
end

peak_avg = mean(p,'all');
width_avg = mean(w,'all');
% find the widht to peak ratio
% a high contrast image has a smaller width and larger peak
% the WP_ratio will be greater in high quality images
WP_ratio = width_avg/peak_avg;    
% a weighted average of key indicators is returned    
value = ((1-WP_ratio)+ratio+peak_val)/3;  


else
    disp('ERROR, ENTER VOLUME DATA')
    value = 0;


end

