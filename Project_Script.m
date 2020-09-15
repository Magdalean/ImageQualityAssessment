
clear all 
close all
%% Load Lung MHD Volumes
[volCT_05, infoCT_05] = imageRead('C:\Users\Magdalean\Documents\SEM_8\IMAGE ANALYSIS\Lab1\Lab1 - LungCT\Lab1 - LungCT\noise_0.5x_post.mhd','mhd');
lung_05 = double(volCT_05.data);
[volCT_10, infoCT_10] = imageRead('C:\Users\Magdalean\Documents\SEM_8\IMAGE ANALYSIS\Lab1\Lab1 - LungCT\Lab1 - LungCT\noise_10x_post.mhd','mhd');
lung_10 = double(volCT_10.data);
[volCT_post, infoCT_post] = imageRead('C:\Users\Magdalean\Documents\SEM_8\IMAGE ANALYSIS\Lab1\Lab1 - LungCT\Lab1 - LungCT\training_post.mhd','mhd');
lung_post = double(volCT_post.data);

%% Load Brain mat files
path = 'C:\Users\Magdalean\Documents\SEM_8\IMAGE ANALYSIS\Lab1\Lab1 - BrainMRI2\Lab1 - BrainMRI2';
Files = dir(path);
i = 1;

for k=1:size(Files)
   FileNames=Files(k).name;
   if FileNames == '.'
       '';
   else
       filepath = strcat(path,'\',FileNames);
       volbrains{i} = load(filepath);
       i = i +1;
   end
end

SLICE = 90;
    
    BrainVol1 = volbrains{1,1}.vol;
    BrainVol2 = volbrains{1,2}.vol;
    BrainVol3 = volbrains{1,3}.vol;
    BrainVol4 = volbrains{1,4}.vol;
    BrainVol5 = volbrains{1,5}.vol;
    BrainVol6 = volbrains{1,length(volbrains)}.vol;
    
    
    input1 = BrainVol1;
    input2 =BrainVol2;
    input3 =BrainVol3;
    input4 =BrainVol4;
    input5 =BrainVol5;
    input6 =BrainVol6;


%% FINAL CALL
%% EDGE QUALITY 

quality_edge_b1= imageQuality_edge(input1, 'brain');
quality_edge_b2= imageQuality_edge(input2, 'brain');
quality_edge_b3= imageQuality_edge(input3, 'brain');
quality_edge_b4= imageQuality_edge(input4, 'brain');
quality_edge_b5= imageQuality_edge(input5, 'brain');
quality_edge_b6= imageQuality_edge(input6,'brain');

quality_edge_l05 = imageQuality_edge(lung_05, 'lung');
quality_edge_l = imageQuality_edge(lung_post,'lung');
quality_edge_l15 = imageQuality_edge(lung_10, 'lung');


%% sharpened images
sharp_b1 = imsharpen(input1,'Radius',2,'Amount',1);
sharp_b2 = imsharpen(input2,'Radius',2,'Amount',1);
sharp_b3 = imsharpen(input3,'Radius',2,'Amount',1);
sharp_b4 = imsharpen(input4,'Radius',2,'Amount',1);
sharp_b5 = imsharpen(input5,'Radius',2,'Amount',1);
sharp_b6 = imsharpen(input6,'Radius',2,'Amount',1);


sharp_l05 = imsharpen(lung_05,'Radius',2,'Amount',1);
sharp_l1 = imsharpen(lung_post,'Radius',2,'Amount',1);
sharp_l10= imsharpen(lung_10,'Radius',2,'Amount',1);


quality_edge_sb1= imageQuality_edge(sharp_b1, 'brain');
quality_edge_sb2= imageQuality_edge(sharp_b2, 'brain');
quality_edge_sb3= imageQuality_edge(sharp_b3, 'brain');
quality_edge_sb4= imageQuality_edge(sharp_b4, 'brain');
quality_edge_sb5= imageQuality_edge(sharp_b5, 'brain');
quality_edge_sb6= imageQuality_edge(sharp_b6,'brain');

quality_edge_sl05= imageQuality_edge(sharp_l05, 'brain');
quality_edge_sl1= imageQuality_edge(sharp_l1, 'brain');
quality_edge_sl10= imageQuality_edge(sharp_l10, 'brain');
%% NOISE QUALITY  
quality_noise_b1= imageQuality_noise(input1, 'brain');
quality_noise_b2= imageQuality_noise(input2, 'brain');
quality_noise_b3= imageQuality_noise(input3, 'brain');
quality_noise_b4= imageQuality_noise(input4, 'brain');
quality_noise_b5= imageQuality_noise(input5, 'brain');
quality_noise_b6=imageQuality_noise(input6,'brain');

quality_noise_l = imageQuality_noise(lung_post,'lung');
quality_noise_l05 = imageQuality_noise(lung_05, 'lung');
quality_noise_l15 = imageQuality_noise(lung_10, 'lung');


%% CONTRAST QUALITY 

quality_contrast_b1= imageQuality_contrast(input1, 'brain');
quality_contrast_b2= imageQuality_contrast(input2, 'brain');
quality_contrast_b3= imageQuality_contrast(input3, 'brain');
quality_contrast_b4= imageQuality_contrast(input4, 'brain');
quality_contrast_b5= imageQuality_contrast(input5, 'brain');
quality_contrast_b6=imageQuality_contrast(input6,'brain');

quality_contrast_l = imageQuality_contrast(lung_post,'lung');
quality_contrast_l05 = imageQuality_contrast(lung_05, 'lung');
quality_contrast_l10 = imageQuality_contrast(lung_10, 'lung');




