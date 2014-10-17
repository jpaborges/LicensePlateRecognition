function letter=im2char(img,Template)
%Receives a img and return a Char with the best correlation
if (nargin < 2)
    load('Template.mat') % Loads the templates of characters in the memory.
end

img=imresize(img,[45 20]); % Resize the input image so it can be compared with the template's images.
%improve the image based on dilatation and invert the binary, so its easy
%to correlate
img = imdilate(~im2bw(img,0.6),strel('line',3,90));
try
    probabily= zeros(1,length(Template));
    for i=1:length(Template)
        probabily(i) = corr2(Template{i},img); % Correlation the input image with every image in the template for best matching.
    end
    %%%disp(probabily);
    if (max(probabily) < 0.01)
        letter = '-'; %did not recognize
    else
        vd=find(probabily==max(probabily)); % Find the index of the most probable character
        %Series of ifs based on the created template
        if (vd==1 || vd==2)
            letter='A';
        elseif vd==3 || vd==4
            letter='B';
        elseif vd==5 || vd==6
            letter='C';
        elseif vd==7 || vd==8
            letter='D';
        elseif vd==9 || vd==10
            letter='E';
        elseif vd==11 || vd==12
            letter='F';
        elseif vd==13 || vd==14
            letter='G';
        elseif vd==15
            letter='H';
        elseif vd==16
            letter='I';
        elseif vd==17 || vd==18
            letter='J';
        elseif vd==19
            letter='K';
        elseif vd==20 || vd==21
            letter='L';
        elseif vd==22 || vd==23
            letter='M';
        elseif vd==24|| vd==25
            letter='N';
        elseif vd==26 || vd==27
            letter='O';
            
        elseif vd==28 || vd==29
            letter='P';
        elseif vd==30 || vd==31
            letter='Q';
        elseif vd==32 || vd==33
            letter='R';
        elseif vd==34 || vd==35
            letter='S';
        elseif vd==36
            letter='T';
        elseif vd==37
            letter='U';
        elseif vd==38
            letter='V';
        elseif vd==39
            letter='W';
        elseif vd==40
            letter='X';
        elseif vd==41 || vd==42 || vd==10
            letter='Y';
        elseif vd==43
            letter='Z';
            
        elseif vd==44
            letter='0';
        elseif vd==45 || vd==46
            letter='1';
        elseif vd==47|| vd==48
            letter='2';
        elseif vd==49 || vd==50
            letter='3';
        elseif vd==51 || vd==52
            letter='4';
        elseif vd==53 || vd==54
            letter='5';
        elseif vd==55 || vd==56
            letter='6';
        elseif vd==57|| vd==58
            letter='7';
        elseif vd==59 || vd==60
            letter='8';
        elseif vd==61 || vd==62
            letter='9';
        else
            letter='-';
        end
    end
catch
    letter = '-'; %error
end
end