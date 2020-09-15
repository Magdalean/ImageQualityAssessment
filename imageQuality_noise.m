function [value] = imageQuality_noise(image,type)
%IMAGEQUALITY_NOISE This function will accept a volume of data array. 
%   Please enter the image type in quotation (case insensitive)
%   Accepted Image types: 'brain' or 'lung'
%   It takes the middle slice of the image and then procceeds to see the
%   change in the key indicators: 
%   Width to Peak ratio. 
%   Number of Peaks.
%   Average Frequency.
%   Entropy.
%   ** This is a weighted Metric **

Dimension = ndims(image);           % Ensures the input is a volume.
if Dimension == 3
    len = round(length(image(1,1,:)));
    mid = round(len/2);
    image = image(:,:,mid);

[bins, freq] = intensityHistogram(double(image));

% Moving averaging the Histogram to ensure small peaks are not counted. 
freq2 = freq;

% Follows different comparisions if the imput image is Lung vs Brain 
if strcmpi(type,'lung')
    for i = 1:(length(freq)-5)
        freq2(i)= mean(freq(i:i+5));
    end
end

% Number of Peaks from Intensity Histogram
numpeaks = peakdet(image,type);

% Follows different comparisions if the imput image is Lung vs Brain 
if strcmpi(type,'brain')    
    if numpeaks == 3
        peak_val = 1;
    elseif numpeaks == 2
        peak_val = 0.5;
    elseif numpeaks == 4
        peak_val = 0.5;
    else
        peak_val = 0;
    end

    % Detects Peaks using a minimum prominance and distance of 100 
    [pks,locs,w,p]= findpeaks(freq2,bins,'MinPeakDistance', 100,'MinPeakProminence', 100,'Annotate','extents','WidthReference','halfprom');
    findpeaks(freq2,bins,'MinPeakProminence', 100,'Annotate','extents','WidthReference','halfprom')
    %title('Signal Peak Widths - Inputs')

elseif strcmpi(type,'lung')
    if numpeaks == 4
        peak_val = 1;
    elseif numpeaks == 3
        peak_val = 0.5;
    elseif numpeaks == 3
        peak_val = 0.5;
    else
        peak_val =0;
    end
    %figure
    [pks,locs,w,p]= findpeaks(freq2,bins,'MinPeakDistance', 100,'MinPeakProminence', 100,'Annotate','extents','WidthReference','halfprom');
    findpeaks(freq2,bins,'MinPeakDistance', 100,'MinPeakProminence', 100,'Annotate','extents','WidthReference','halfprom')
    %title('Signal Peak Widths - Inputs')

end

peak_avg = mean(p,'all');   % Finding average prominance

width_avg = mean(w,'all');   % Finding average width
WP_ratio = width_avg/peak_avg;
entropy = Entropy_Metric(image);

med_filt_freq_dif = delta_freq(image);


% A weighted average of the change in key indactors is returned. 
value = ((1-WP_ratio)+2*peak_val+med_filt_freq_dif +entropy)/5;

else
    disp('ERROR, ENTER VOLUME DATA')
    value = 0;
end

