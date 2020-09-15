function [out] = spatial_filter(img, h)
[a,b]= size(h);
padm = floor(a/2);
padn = floor(b/2);
pad_img =padarray(img,[padm padn],0,'both');
[m,n]= size(pad_img);

out1 = zeros(m,n);
%out = corr2(img,h)
for j = padn + 1:n-padn
    for i = padm + 1:m-padm
        out1(i,j) = sum(h.*(pad_img(i-padm:i+padm,j-padn:j+padn)),'all');
    end
end

out = out1(padm+1:end-padm, padn + 1:end-padn);
% omin = min(out2,[],'all');
% out = out2 - omin;

end