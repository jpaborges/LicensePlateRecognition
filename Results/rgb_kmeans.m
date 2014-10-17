function [ idx ] = rgb_kmeans(image)
%*************************************************************************
%  idx = rgb_kmeans(image)
%
% Description: This function returns the RGB KMeans  
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

im_r = image(:,:,1);
im_g = image(:,:,2);
im_b = image(:,:,3);


im_v = [im_r(:) im_g(:) im_b(:)]; %Vector

% figure()
% surf(image(:,:,1))
% hold on
% surf(image(:,:,2))
% hold on
% surf(image(:,:,3))
% shading('INTERP');

idx = reshape(kmeans(im_v,6,'Distance','sqEuclidean','Replicates',3),x,y);

figure()
imagesc(idx);








end

