function [ letters ] = extractLetters( plates )
%extractLetters receives a set of license plate and return a set with
%possible letters in these plates
if (~iscell(plates))
    
    img = cell(1,1);
    img{1} = plates;
else
    img = plates;
end
letters = cell(1,length(img));

for k=1:length(img)
    [s1 s2 ~] = size(img{k});
    i2 = edge(rgb2gray(img{k}),'canny',0.3); %increase the edges 

    %separate one letter from another
    se = strel('square',2);
    i3 = imdilate(i2,se);
    i4 = imfill(i3,'holes');

    %Connect components
    [Ilabel num] = bwlabel(i4,4);
    Iprops = regionprops(Ilabel);
    Ibox = [Iprops.BoundingBox];
    Ibox = reshape(Ibox,[4 num]);
    
    %%figure;
    %%imshow(Plate);
    %%hold on;
    out = cell(1,num); %worse case it will have num images as letter candidates
    for cnt = 1:num
        %the size and area of the image has to make sense...
        %the image was resized to [100 NaN]
        if (Iprops(cnt).Area > 100 && Iprops(cnt).Area < 1000)
            aux = Ibox(:,cnt);
            if ((aux(3) < s2/4) && (aux(4) > s1/3) )
                %w = waitforbuttonpress;
                %%rectangle('position',Ibox(:,cnt),'edgecolor','r');
                
                out{cnt} = imresize(imcrop(img{k}, aux),[45 20]);
                %%figure; imshow(subImage);
                
            end
        end
    end
    letters{k} = out(~cellfun(@isempty,out)); %eliminate empty cells
    %%hold off;
end
letters = letters(~cellfun(@isempty,letters)); %eliminate empty cells

end

