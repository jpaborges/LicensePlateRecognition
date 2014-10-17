function segments = segmentation ( img)
%This function receives a binary image and segmentates in N parts
% [w l] = size(img);
% newl = round(l/N);
% segments = zeros(w,newl,N);
% h = round(0.1*w/N);
% aux = sum(img);
% j =1;
%     i = 1;
%     while (i < l-h)
%         if (sum(aux(i:i+h)) >= h*w)
%             %found the area that should be separated
%             t = img(:,1:30);
%             t = padarray(t,[0 (round((newl- lenth(t))/2))]);
% 
%             if (lenght(t) > newl)
%                 t = t(:,1:newl);
%             end
% 
%             if (lenght(t) < newl)
%                 t = horzcat(t,zeros(w,newl-length(t)));
%             end
% 
%            segments(:,:,j) = t;
%         else
%             i = i+1;
%         end
%     end

if iscell(img)
    for k=1:length(img)
        if length(size(img{k})) > 2
            i2 = edge(rgb2gray(img{k}),'canny',0.3);
        else
            i2 = edge(img{k},'canny',0.3);
        end

        se = strel('square',2);
        i3 = imdilate(i2,se);

        i4 = imfill(i3,'holes');

        [Ilabel num] = bwlabel(i4,4);
        disp(num);
        Iprops = regionprops(Ilabel);
        Ibox = [Iprops.BoundingBox];
        Ibox = reshape(Ibox,[4 num]);
        figure; imshow(img{k});
        hold on;
        segments = 0;
        disp(k);
        for cnt = 1:num
            if (Iprops(cnt).Area > 500 && Iprops(cnt).Area < 800)
            rectangle('position',Ibox(:,cnt),'edgecolor','r');
            segments = segments + 1;
            end
        end
        disp(segments);
        hold off;
    end
else
    if length(size(img)) > 2
            i2 = edge(rgb2gray(img),'canny',0.3);
        else
            i2 = edge(img,'canny',0.3);
    end

    se = strel('square',2);
    i3 = imdilate(i2,se);

    i4 = imfill(i3,'holes');

    [Ilabel num] = bwlabel(i4,4);
    disp(num);
    Iprops = regionprops(Ilabel);
    Ibox = [Iprops.BoundingBox];
    Ibox = reshape(Ibox,[4 num]);
    disp(Ibox(:,2));
    imshow(img);
    hold on;
    segments = 0;
    for cnt = 1:num
        if (Iprops(cnt).Area > 500 && Iprops(cnt).Area < 1500)
        rectangle('position',Ibox(:,cnt),'edgecolor','r');
        segments = segments + 1;
        end
    end
    disp(segments);
end




end

