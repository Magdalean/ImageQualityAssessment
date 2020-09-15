function [kernel] = derivative_kernel(type,direction)
% Enter the type of derivative kernel to implement as the first argument 
% Select from :
%   central, forward, perwitt, sobel
% Enter the desired direction of the gradient as the second arguement
% Select from :
%   vertical, horizontal
% Ensure the selection is typed in all lowercase
% Example entry:
%   kernel = derivative_kernel('central,vertical');

if strcmp(type,'central')
    kernel1 = [1 0 -1];
elseif strcmp(type,'forward')
    kernel1 = [0 1 -1];
elseif strcmp(type,'perwitt')
    kernel1 = [1 0 -1; 1 0 -1; 1 0 -1];
elseif strcmp(type,'sobel')
    kernel1 = [1 0 -1; 2 0 -2; 1 0 -1];
else 
    disp('Please refine your selection');
    disp('For more information, enter >>help derivative_kernel');
    kernel1 = 0;
end

if strcmp(direction,'vertical')
    kernel = kernel1;
elseif strcmp(direction,'horizontal') 
    kernel = kernel1';
else
    disp('Please refine your selection');
    disp('For more information, enter >>help derivative_kernel');
    kernel = 0;
end

end

