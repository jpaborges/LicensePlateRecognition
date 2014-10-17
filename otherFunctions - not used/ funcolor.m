function [ iy ] = funcolor(input,image)
%*************************************************************************
%  idx = loc_kmeans(image)
%
% Description: This function returns the RGB Values for Cartooning of images 
%   Note: Function requires both the input and image to be the same size
%       
% Input Arguments:
%	Name: input
%	Type: vector
%	Description: Segmeneted Image
%
% Input Arguments:
%	Name: image
%	Type: vector
%	Description: input image
%
% Output Arguments:
%	Name: idx
%	Type: vector
%	Description: output
%
% 
% Coded by Nate
%*************************************************************************

[x y z] = size(image);

iy = zeros(x,y,3); 

s_vals = unique(input(find(input ~= 0)));
n = length(s_vals);

for i = 1:n
   
    loc_on = (input == s_vals(i)); %Find pixel locations of components in image
    
    %Get RGB Values
    temp_R = image(:,:,1).*loc_on; 
    temp_G = image(:,:,2).*loc_on;
    temp_B = image(:,:,3).*loc_on;
    
    %Average Values
    temp_R = sum(sum(temp_R))/sum(sum(loc_on));
    temp_G = sum(sum(temp_G))/sum(sum(loc_on));
    temp_B = sum(sum(temp_B))/sum(sum(loc_on));
    
    %Set Values
    iy(:,:,1) = iy(:,:,1) + (loc_on.*temp_R);
    iy(:,:,2) = iy(:,:,2) + (loc_on.*temp_G);
    iy(:,:,3) = iy(:,:,3) + (loc_on.*temp_B);
    
end


end

