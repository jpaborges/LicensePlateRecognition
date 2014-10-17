function [ o ] = showIm( images )
%Receive a cell of images and show every image
close all;
if iscell(images)
    if iscell(images{1})
       for i=1:length(images{1}) 
           figure;   
           for j=1:length(images)
            subplot(length(images),1,j), subimage(images{j}{i});
           end
       end
    else
    for i=1:length(images)      
            figure, imshow(images{i});
    end
    end
end


o = 1;
    


end

