function [ idx ] = hsv_kmeans(image,rz)

%*************************************************************************
%  idx = hsv_kmeans(image,rx)
%
% Description: This function returns the HSV Kmeans 
%
% Input Arguments:
%	Name: image
%	Type: vector
%	Description: input image
%
%	Name: rx
%	Type: scalar
%	Description: Scale Resolution
%
% Output Arguments:
%	Name: idx
%	Type: vector
%	Description: output
%
% 
% Coded by Nate
%*************************************************************************


image = rgb2hsv(image); %Convert to HSV
image = imresize(image, rz);


[x y z] = size(image);

im_h = image(:,:,1);
im_x = image(:,:,2);
im_v = image(:,:,3);


im_v = [im_h(:) im_x(:) im_v(:)]; %Data Vector

% figure()
% surf(image(:,:,1))
% hold on
% surf(image(:,:,2))
% hold on
% surf(image(:,:,3))
% shading('INTERP');

idx = reshape(kmeans(im_v,2,'Distance','sqEuclidean','Replicates',1),x,y);

figure()
imagesc(idx);



end

