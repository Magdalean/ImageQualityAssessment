function [Metric] = Entropy_Metric(img)
%ENTROPY_METRIC 
%   Detailed explanation goes here

% Performing a medial Filter of 5x5. 
med_img = medfilt(img,5,5);
LocEn_MedianImg = entropyfilt(med_img);
LocEn_Img = entropyfilt(img);

% figure
% subplot(1,2,1)
% imshow(LocEn_MedianImg,[])
% title('Entropy of Median')
% subplot(1,2,2)
% imshow(LocEn_Img,[])
% title('Entropy of Original')

avg_intensitymedian =  mean(LocEn_MedianImg,'all');
avg_intensityimg = mean(LocEn_Img,'all');

Percent_Change = abs((avg_intensitymedian - avg_intensityimg )/avg_intensityimg);
if Percent_Change == Inf        %If no change was occured, inifite was resulted.
    Percent_Change = 0;         
end

%Value returned is 1 - the change, because a higher entropy shows 
% a lower quality. 
Metric = 1- Percent_Change;
end

