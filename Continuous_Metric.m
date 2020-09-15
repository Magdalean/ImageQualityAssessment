function [Metric] = Continuous_Metric(img,type)
%   Enter "Brain" or "Lung" to determine type of image
%normalize image
img = img/max(img,[],'all');
% denoise image
img_MedFilt = medfilt(img,5,5);

%Producing a gradient map of image using rangefilt function
RF_img_MedFilt= rangefilt(img_MedFilt);

% Using  graythreshold (Uses Otsu Threshold Method) to Binarize
BWimg_MedFilt = imbinarize(RF_img_MedFilt,graythresh(RF_img_MedFilt));

% figure
% imshowpair(RF_img_MedFilt, BWimg_MedFilt,'montage')
% Finding the connected components in BW image
CC = bwconncomp(BWimg_MedFilt);

% find the number of connected groups
groupsCC = CC.NumObjects;

% Note that 11 and 68 were decided after testing the dataset with the best
% edges. 11 and 68 are the number of groups that a dataset should
% have.
if strcmpi(type, 'brain')
    Metric = 11/groupsCC;  
elseif strcmpi(type,'lung')
    Metric = 68/groupsCC;
    if Metric >1
        Metric = 1;
    end
    

end


