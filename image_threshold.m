function [thresholded_img] = image_threshold(img, T)

[m,n]= size(img);
thresholded_img = zeros(m,n);
for i = 1:m
    for j = 1:n
        if img(i,j)> T
            thresholded_img(i,j)= 1;
        else
            thresholded_img(i,j)= 0;
        end
        
    end
end

end

