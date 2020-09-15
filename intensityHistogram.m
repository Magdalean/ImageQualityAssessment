function [bins,freq] = intensityHistogram(imagedata)
[m,n,k]= size(imagedata);
dim = m*n*k;
% top = length(unique(imagedata));
bins = unique(imagedata);

for i = 1:length(bins)
    indx = find(imagedata == bins(i));
    bins(i,2) = length(indx);
end

freq = double(bins(:,2));
%freq(1) = 0;
bins = bins(:,1);

%figure
% plot(bins, freq);
% xlabel('Intensity Bins');
% ylabel('Frequency');
% title('Intensity Histogram')


% norm = freq./(m*n*k);
% figure;
% plot(bins, norm);
% xlabel('Intensity Bins');
% ylabel('Frequency');
% title('Normalized Intensity Histogram ');

end
