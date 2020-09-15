function [output_image] = contrast_stretch_proj(img)

%shift the image if it is less than 0
if min(img(:))<0
    input_image = img - min(img(:));
else 
    input_image = img;
end

rmax = double(max(input_image,[],'all'));
rmin = double(min(input_image(:)));
range = rmax - rmin;
if range > 255 
    %output_image = uint16((2^16)*((input_image-rmin)./(rmax-rmin)));
    output_image = uint64((2^64)*((input_image-rmin)./(rmax-rmin)));
else
    output_image = uint8(255*((input_image-rmin)./(rmax-rmin)));
end
end



