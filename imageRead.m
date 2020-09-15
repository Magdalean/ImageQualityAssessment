function [img, info]=imageRead(path, imageFormat)
if imageFormat == 'dcm'
    info = dicominfo(path);
    img = dicomread(info);
elseif imageFormat =='png' | imageFormat == 'pgm'
    img = imread(path);    
elseif imageFormat =='mhd'
    [img, info] = read_mhd(path);
else
     img = imread(path);
     info = 1; 
  
end
end

