function [output_med] = medfilt(img,H,W)
[m,n]= size(img);
padm = floor(H/2);
padn = floor(W/2);

pad_img =padarray(img,[padm padn],0,'both');

[a,b] = size(pad_img);
output_med1 = zeros(a,b);

for i = 1+padm:a-padm
    for j = 1+padn:b-padn
        patch = pad_img(i-padm:i+padm,j-padn:j+padn);
        output_med1(i,j) = median(patch(:));
    end
end

output_med = output_med1(padm+1:end-padm, padn+1:end-padn);

end


