function [ idx ] = loc_kmeans( image )
%*************************************************************************
%  idx = loc_kmeans(image)
%
% Description: This function returns the RGB+Location KMeans 
%
% Input Arguments:
%	Name: image
%	Type: vector
%	Description: input image
%
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


im_x = zeros(x,y);
im_y = zeros(x,y);

%Get pixel locations
for i = 1:x
    for j = 1:y
       im_y(i:j) = j - 1;
       im_x(i,j) = i - 1;
    end
end

%Normalize to 1
im_y = im_y ./ sum(sum(im_y)); 
im_x = im_x ./ sum(sum(im_x));

%Seperate Channels
im_r = image(:,:,1);
im_g = image(:,:,2); 
im_b = image(:,:,3);

im_v = [im_r(:) im_g(:) im_b(:) im_x(:) im_y(:)]; %Vector

% figure()
% surf(image(:,:,1))
% hold on
% surf(image(:,:,2))
% hold on
% surf(image(:,:,3))
% shading('INTERP');

idx = reshape(kmeans(im_v,5,'Distance','sqEuclidean','Replicates',3),x,y);

figure()
imagesc(idx);

end

