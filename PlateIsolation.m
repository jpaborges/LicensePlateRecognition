function [ plate ] = PlateIsolation( images, mask )
%If this function receives two arguments, image and mask it tries to
%isolate the ROI in the image based on that mask. If it only receive the
%image it assumes that the license plate represents the majority of the image and
%tries to isolate the ROI based on the number of edges in the images. Both
%image and mask can be cell

if (~iscell(images))
    
    img = cell(1,1);
    img{1} = images;
else
    img = images;
end
plate = cell(1,length(img));

if (nargin == 2)
    for k=1:length(img)
        p = cut(mask);
        a = min(p);
        b = max(p);
        plate{k} = img{k}(a(1):b(1),a(2):b(2));
        %disp(mask);
    end
else
    for k=1:length(img)
        %%%%%%isolate plate
        Plate = 0;
        A=img{k};
        [h,w,~]=size(A);
        
        %Convert the image to grayscale and do edge detection
        A = rgb2gray(A);
        A = im2bw(A,graythresh(A)*1.3); %The factor 1.3 was decided in a try and error approach
        A=edge(A,'roberts');
        horHist = sum(A);
        
        %define treshold for horizontal histogram 
        gem=max(horHist)/2.3; %2.3 was according to the paper
        hstart=0;
        hcounter=0;
        arc=0;
        hcoor=zeros(1,2);
        
        %find the start and end of the license plate based on the
        %horizontal histogram
        for i=1:w
            if horHist(i)>gem(1)
                if(hstart==0)
                    hstart=i;
                end
                hcounter=0;
            else
                if hstart>0
                    if hcounter>(w*0.07)
                        heinde=i-hcounter;
                        width=heinde-hstart;
                        if(width>(w*0.1))
                            arc=arc+1;
                            hcoor(arc,1)=hstart;
                            hcoor(arc,2)=width;
                        end
                        hstart=0;
                        hcounter=0;
                    end
                    hcounter=hcounter+1;
                end
            end
        end
        [ww,~]=size(hcoor);
        hstart=0;
        hwidth=0;
% If there are many horizontal locations, just pick out the widest.
        for i=1:ww
            if(hcoor(i,2)>hwidth)
                hwidth=hcoor(i,2);
                hstart=hcoor(i,1);
            end
        end
        
        if ((hstart > 0) && (hwidth > 0)) %if some error happen this if will avoid the propagation
            A=A(:,hstart:(hstart+hwidth),:); %isolate the horizontal part
            
            verHist=zeros(h);
            
            %vertical edge counting, based on neighbor
            for j=1:h
                tot=0;
                for i=2:hwidth
                    if (A(j,i-1)==1 && A(j,i)==0) || (A(j,i-1)==0 && A(j,i)==1)
                        tot=tot+1;
                    end
                end
                verHist(j)=tot;
            end
            verh=zeros(1);
            count=1;
            
            for i=1:h
                if(verHist(i)>0)
                    verh(count)=verHist(i);
                    count=count+1;
                end
            end
            gem=mean(verh);
            vstart=0;

            vcounter=0;
            arc=0;
            vcoor=zeros(1,2);
            h*0.07;
         
            %define the vertical region
            for i=1:h
                if verHist(i)>gem(1)
                    if(vstart==0)
                        vstart=i;
                    end
                    vcounter=0;
                else
                    if vstart>0
                        if vcounter>(h*0.03)
                            veinde=i-vcounter;
                            height=veinde-vstart;
                            if(height>(h*0.05))
                                arc=arc+1;
                                vcoor(arc,1)=vstart;
                                vcoor(arc,2)=height;
                            end
                            vstart=0;
                            vcounter=0;
                        end
                        vcounter=vcounter+1;
                    end
                end
            end
            [l,~]=size(vcoor);
            
            %Crop the plate
            if ((vcoor(l,1) > 0) && (vcoor(l,2) > 0))
                Plate=img{k}(vcoor(l,1):vcoor(l,1)+vcoor(l,2),hstart:(hstart+hwidth),:);
                
            end   
        end
        if (Plate ~= 0)
            plate{k} = imresize(Plate, [100 NaN]);
        else
            %An error happened
            disp('Error on : ');
            disp(k); 
        end     
    end
    plate = plate(~cellfun('isempty',plate));%eliminate empty cells. I.E cells with errors.
    %plate = ~cellfun(@isempty,plate); %eliminate empty cells. I.E cells with errors.
    
end
end
        
