function [output_image] = contrast_stretch(input_image)
rmax = double(max(input_image,[],'all'));
rmin = double(min(input_image(:)));
%range = rmax - rmin;
%output_image = uint64((2^64)*((input_image-rmin)./(rmax-rmin)));


output_image = uint8(255*((input_image-rmin)./(rmax-rmin)));

end


