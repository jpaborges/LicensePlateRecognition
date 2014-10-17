function numberPlateExtraction(input)
%NUMBERPLATEEXTRACTION extracts the characters from the input number plate image.
if (~iscell(input))
    
    img = cell(1,1);
    img{1} = input;
else
    img = input;
end

for k=1:length(img)       
    %%%%%%isolate plate
    disp(k);
    Plate = 0;
    A=img{k};
    org=A;
    [h,w,f]=size(A);

    %we converteren de afbeelding naar grijsschaal om een treshhold te kunnen
    %opstellen voor de binaire afbeelding: alles onder de treshold is 1, alles daarboven wordt 0
    A = rgb2gray(A);
    level = graythresh(A);
    %de afbeelding wordt omgezet naar een binaire afbeelding, we verhogen de
    %treshold nog met 30% voor een beter resultaat te krijgen
    A = im2bw(A,level*1.3);
    %vervolgens maken we gebruik van een ingebouwde matlab-functie voor
    %edge-detection adhv 
    A=edge(A,'roberts');


    horHist=zeros(w);
    %Het aantal witte pixels per kolom worden opgeteld en opgeslagen
    for i=1:w
        tot=0;
        for j=1:h
            if (A(j,i)==1)
                tot=tot+1;
            end
        end
        horHist(i)=tot;
    end
    %berekende treshold 
    gem=max(horHist)/2.3;
    hstart=0;
    heinde=0;
    width=0;
    hcounter=0;
    arc=0;
    hcoor=zeros(1,2);
    %als het aantal witte pixels gedurende een bepaalde afstand (vastgelegd in percentages) groter is dan de
    %treshold wordt deze positie opgeslagen als de horizontale positie van de
    %nummerplaat
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
                    heinde=0;
                    width=0;
                end
                hcounter=hcounter+1;
            end
        end
    end
    [ww,f]=size(hcoor);
    hstart=0;
    hwidth=0;
    %in het geval er meerdere horizontale plaatsen gevonden zijn voor de
    %nummerplaat dan pikken we enkel de breedste positie er uit.
    for i=1:ww
        if(hcoor(i,2)>hwidth)
            hwidth=hcoor(i,2);
            hstart=hcoor(i,1);
        end
    end
    
    if ((hstart > 0) && (hwidth > 0))
        A=A(:,hstart:(hstart+hwidth),:);

        verHist=zeros(h);
        %het aantal keer dat een pixel en zijn buur in een rij tegenovergesteld
        %zijn van elkaar wordt opgeslagen voor die rij.
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
        coun=1;
        %we berekenen de gemiddelde waarde van het aantal tegenovergestelde
        %naburige pixels in een rij, dat gemiddelde gebruiken we later als treshold
        for i=1:h
            if(verHist(i)>0)
                verh(coun)=verHist(i);
                coun=coun+1;
            end
        end
        gem=mean(verh);
        vstart=0;
        veinde=0;
        height=0;
        vcounter=0;
        arc=0;
        vcoor=zeros(1,2);
        h*0.07;
        %als het aantal tegenovergestelde naburige pixels per rij gedurende een
        %bepaalde breedte groter is dan het gemiddelde en vervolgens van een
        %bepaalde hoogte is tov de afmetingen van de afbeelding, dan wordt deze
        %positie opgeslagen als mogelijke verticale plaats van de nummerplaat
        for(i=1:h)
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
                        veinde=0;
                        height=0;
                    end
                    vcounter=vcounter+1;
                end
            end
        end
        [l,f]=size(vcoor);
        %nu we de verschillende mogelijke posities berekend hebben kunnen we
        %overgaan tot de segmentatie
        if ((vcoor(l,1) > 0) && (vcoor(l,2) > 0))
            Plate=org(vcoor(l,1):vcoor(l,1)+vcoor(l,2),hstart:(hstart+hwidth),:);





            %%%%%% Read characther
            Plate = imresize(Plate, [100 NaN]);
             [s1 s2 s3] = size(Plate);
                if length(size(Plate)) > 2
                        i2 = edge(rgb2gray(Plate),'canny',0.3);
                else
                        i2 = edge(Plate,'canny',0.3);
                end

                se = strel('square',2);
                i3 = imdilate(i2,se);

                i4 = imfill(i3,'holes');

                [Ilabel num] = bwlabel(i4,4);
                Iprops = regionprops(Ilabel);
                Ibox = [Iprops.BoundingBox];
                Ibox = reshape(Ibox,[4 num]);
                figure;
                imshow(Plate);
                hold on;
                for cnt = 1:num

                    if (Iprops(cnt).Area > 100 && Iprops(cnt).Area < 1000)
                         aux = Ibox(:,cnt);
                         if ((aux(3) < s2/4) && (aux(4) > s1/3) )
                             %w = waitforbuttonpress;
                            rectangle('position',Ibox(:,cnt),'edgecolor','r');
                             subImage = imcrop(i4, aux);
                            %figure; imshow(subImage);
                            disp(readLetter(subImage));
                         end
                    end
                end
                hold off;
        end
    end
    if (Plate == 0)
        disp('ERROR finding plate');
    end
end

% %%%%%Method 2
% disp('Method 2');
% 
% f=imresize(A, [100 NaN]);
% [s1 s2 s3] = size(f);
% g=rgb2gray(f); % Converting the RGB (color) image to gray (intensity).
% g=medfilt2(g,[3 3]); % Median filtering to remove noise.
% se=strel('disk',1); % Structural element (disk of radius 1) for morphological processing.
% gi=imdilate(g,se); % Dilating the gray image with the structural element.
% ge=imerode(g,se); % Eroding the gray image with structural element.
% gdiff=imsubtract(gi,ge); % Morphological Gradient for edges enhancement.
% gdiff=mat2gray(gdiff); % Converting the class to double.
% gdiff=conv2(gdiff,[1 1;1 1]); % Convolution of the double image for brightening the edges.
% gdiff=imadjust(gdiff,[0.5 0.7],[0 1],0.1); % Intensity scaling between the range 0 to 1.
% B=logical(gdiff); % Conversion of the class from double to binary. 
% % Eliminating the possible horizontal lines from the output image of
% % regiongrow that could be edges of license plate.
% er=imerode(B,strel('line',50,0));
% out1=imsubtract(B,er);
% % Filling all the regions of the image.
% F=imfill(out1,'holes');
% 
% % Thinning the image to ensure character isolation.
% H=bwmorph(F,'thin',1);
% H=imerode(H,strel('line',3,90));
%     [Ilabel num] = bwlabel(H,4);
%     disp(num);
%     Iprops = regionprops(Ilabel);
%     Ibox = [Iprops.BoundingBox];
%     Ibox = reshape(Ibox,[4 num]);
%     figure;
%     imshow(f);
%     hold on;
%     segments = 0;
%     for cnt = 1:num
%         if (Iprops(cnt).Area > 100 && Iprops(cnt).Area < 1000)
%              aux = Ibox(:,cnt);
%              if ((aux(3) < s2/4) && (aux(4) > s1/3) )
%                 w = waitforbuttonpress;
%                 rectangle('position',Ibox(:,cnt),'edgecolor','r');
%                 disp(aux)
%                  subImage = imcrop(H, aux);
%                 %figure; imshow(subImage);
%                 disp(readLetter(subImage));
%                 segments = segments + 1;
%              end
%         end
%     end
%     disp(segments);


% % Selecting all the regions that are of pixel area more than 100.
% final=bwareaopen(H,100);
% % final=bwlabel(final); % Uncomment to make compitable with the previous versions of MATLAB®
% % Two properties 'BoundingBox' and binary 'Image' corresponding to these
% % Bounding boxes are acquired.
% Iprops=regionprops(final,'BoundingBox','Image');
% % Selecting all the bounding boxes in matrix of order numberofboxesX4; 
% NR=cat(1,Iprops.BoundingBox);
% % Calling of controlling function.
% r=controlling(NR); % Function 'controlling' outputs the array of indices of boxes required for extraction of characters.
% 
% 
% 
% 
% 
% if ~isempty(r) % If succesfully indices of desired boxes are achieved.
%     I={Iprops.Image}; % Cell array of 'Image' (one of the properties of regionprops)
%     noPlate=[]; % Initializing the variable of number plate string.
%     for v=1:length(r)
%         N=I{1,r(v)}; % Extracting the binary image corresponding to the indices in 'r'.
%         figure; imshow(N);
%         letter=readLetter(N); % Reading the letter corresponding the binary image 'N'.
%         while letter=='O' || letter=='0' % Since it wouldn't be easy to distinguish
%             if v<=3                      % between '0' and 'O' during the extraction of character
%                 letter='O';              % in binary image. Using the characteristic of plates in Karachi
%             else                         % that starting three characters are alphabets, this code will
%                 letter='0';              % easily decide whether it is '0' or 'O'. The condition for 'if'
%             end                          % just need to be changed if the code is to be implemented with some other
%             break;                       % cities plates. The condition should be changed accordingly.
%         end
%         noPlate=[noPlate letter] % Appending every subsequent character in noPlate variable.
%     end
% 
%     
% 
% end
end