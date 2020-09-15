function [value] = var_metric(img)
% patch size of H by W
H=10;
W=10;
[m,n]= size(img);

% determine zero pad amount 
if mod(m,H)>0
    padm = H - mod(m,H);
else
    padm = 0;
end

if mod(n,W)>0
    padn = W - mod(n,W);
else
    padn = 0;
end

pad_img =padarray(img,[padm padn],0,'post');
[a,b] = size(pad_img);
index = 1;
% initialize array 
V = zeros((a*b)/(H*W),1);
for i = 1:H:a
    for j = 1:W:b
        patch = pad_img(i:i+H-1,j:j+W-1);
        V(index) = sqrt(var(patch,1,'all'));
        index = index +1;
    end
end

% global standard deviation of the image
GSD = sqrt(var(img,1,'all'));
count = 0;
% iterate through the image
% determine if the patch falls between the range
% if it falls between this range, it is a high contrast area

for i=1:length(V)
    if 1.1*GSD < V(i) && V(i)<= 1.25*GSD
        count = count +1;
    end
end
% divide the number of high contrast areas by the total number of patches
value = count/length(V);
end


