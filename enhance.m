function out = enhance( img, method )
%Enhance enhances the input img using 1 = sobel of a Gaussian or 2 = Log

if (nargin < 2)
    method = 1;
end

if (iscell(img))
    out = cell(1,length(img));
    for k=1:length(img)
        l = graythresh(img{k});

        if (method == 1)
            G = fspecial('gaussian',[5 5],10*l);
            sobelV = [1 0 -1;2 0 -2; 1 0 -1];
            out{k} = img{k} + uint8(imfilter(imfilter(img{k},G,'same'),sobelV));
        elseif (method == 2)
            LOG = fspecial('log',[5 5],l);
            out{k} = img{k} + uint8(imfilter(img{k},LOG,'same'));
        elseif (method ==3)    
            LOG = fspecial('log',[5 5],l);
            out{k} = uint8(imfilter(img{k},LOG,'same'));
        end
        
        %intensify the central region
        [a b] = size(img{k});
        s = tests(img{k});
        sAux = mean(mean(s));
        for i=round(a/3):round(a*2/3)
            for j=round(b/3):round(b*2/3)
                if s(i,j) > sAux
                    out{k}(i,j) = out{k}(i,j)*1.2;
                else
                    out{k}(i,j) = out{k}(i,j)*1.1;
                end
            end
        end
        
    end
else
        l = graythresh(img);

        if (method == 1)
            G = fspecial('gaussian',[5 5],10*l);
            sobelV = [1 0 -1;2 0 -2; 1 0 -1];
            out = img + uint8(imfilter(imfilter(img,G,'same'),sobelV));
        elseif (method == 2)
            LOG = fspecial('log',[5 5],l);
            out = img + uint8(imfilter(img,LOG,'same'));
        end
        
         %intensify the central region
        [a b] = size(img);
        
        for i=round(a/3):round(a*2/3)
            for j=round(b/3):round(b*2/3)
                out(i,j) = out(i,j)*1.1;
            end
        end
end

    

    
    



end

