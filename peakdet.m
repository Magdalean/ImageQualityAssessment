function [numpeaks] = peakdet(image,type)

[bins, freq] = intensityHistogram(double(image));
freq2 = freq;

if strcmpi(type,'lung')
    for i = 1:(length(freq)-5)
        freq2(i)= mean(freq(i:i+5));
    end

[pks,locs,w,p]= findpeaks(freq2,bins,'MinPeakDistance', 100,'MinPeakProminence', 100,'Annotate','extents','WidthReference','halfheight');

else
    [pks,locs,w,p]= findpeaks(freq2,bins,'MinPeakProminence', 100,'Annotate','extents','WidthReference','halfheight');

end

numpeaks = length(pks);
end

