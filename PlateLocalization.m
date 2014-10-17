function out = PlateLocalization(input,method)
%This function aims to isolate the plate region in the image.
%It can receive as input a cell containing a set of images or only one
%image. It is based on smearing. This is to be used if the plate is not the
%determinant of the image. Obs: Not working as expected

    t = .5;


if (nargin < 2)
    method = 4;
end

if (~iscell(input))
    
    img = cell(1,1);
    img{1} = input;
else
    img = input;
end
    
    out = cell(1,length(img));
    for k=1:length(img)       

            %smearing
            mask = im2bw(img{k},t*graythresh(img{k}));
            if (method ==1 || method == 3) % horizontal smearing
                hori_thresh = sum(mask,2);
                h_finx = find(hori_thresh>=500);
                mask(h_finx,:) = 0;
            end
            if (method == 2 || method == 3) % vertical smearing
                ver_thresh = sum(mask,1);
                v_finx = find(ver_thresh<30);
                mask(:,v_finx) = 0;
            end
            
            
            if (length(size(img{k})) == 3) %color img
                masked = zeros(size(img{k}));
                masked(:,:,1) = img{k}(:,:,1) .* uint8(mask);
                masked(:,:,2) = img{k}(:,:,1) .* uint8(mask);
                masked(:,:,3) = img{k}(:,:,1) .* uint8(mask);
            
            else %grayscale
                masked = img{k} .* uint8(mask);
            end
            
            figure, imshow(masked)
            out{k} = mask;
            
            
            
                     
    
    end


end




