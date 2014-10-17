function [ imgs ] = readImages( gray, size, strFolder, format )
%Read all images in the specified folder and return a cell with all images
%with the specified size if size = -1, keep the same size if gray = 1 the
%image will be converted from rgb2gray
if (nargin < 1)
    gray = 0;
end

if (nargin < 2)
    size = [800 600];
end

if (nargin < 4)
    format = 'jpg';
end

if (nargin < 3)
    strFolder = './Images';
end
    
    
list = dir(strcat(strFolder,'/*.',format));
l = length(list);
imgs = cell(1,l);
for k=1:length(list)
    fname = strcat(strFolder,'/',list(k).name);
    if (size == -1)
        imgs{k} = imread(fname);
    else
        imgs{k} = imresize(imread(fname),size);
    end 
    
    if (gray)
       imgs{k} = rgb2gray(imgs{k});
    end
    
end



end

