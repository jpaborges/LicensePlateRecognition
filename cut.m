function [ out ] = cut( Img,i,j )
%Img is a binary image
if (nargin < 3)
    %first iteraction
    %Img = [0 0 0  1 1 1 0 0;0 0 0  1 1 1 0 0; 0 0 0 0 0 0 1 1; 0 0 0 0 0 0 1 1];
    [a b] = find(Img,1);
    %start the recursive part
    out = cut(Img,a,b);
    
else
    %recursive part
    [h w] = size(Img);
    out = NaN;
    if ((i <= h) && (j <= w) && (i >= 1) && (j >= 1) && (Img(i,j) == 1))
        out = [i,j];
        Img(i,j) = -1; %visited
        q = cut(Img,i-1,j);
        if (~isnan(q))
            out = [out;q];
            %set all the values in out as visited
            for k=1:length(out)
                Img(out(k)) = -1; %visited
            end
        end       
        w = cut(Img,i+1,j);
        if (~isnan(w))
            out = [out;w];
            %set all the values in out as visited
            for k=1:length(out)
                Img(out(k)) = -1; %visited
            end
        end 
        r = cut(Img,i,j-1);
        if (~isnan(r))
            out = [out;r];
            %set all the values in out as visited
            for k=1:length(out)
                Img(out(k)) = -1; %visited
            end
        end 
        t = cut(Img,i,j+1);
        if (~isnan(t))
            out = [out;t];
            %set all the values in out as visited
            for k=1:length(out)
                Img(out(k)) = -1; %visited
            end
        end 
        
        out = unique(out,'rows');

        
    end
end

end

