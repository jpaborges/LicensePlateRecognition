clc; clear all; close all;
%**************************************************************************
%NAME:Nathanael Macias                               DATE: Oct. 15, 2012
%--------------------------------------------------------------------------
%PURPOSE: Program solves HW 3 Problems 1
%
%--------------------------------------------------------------------------
%OUTLINE: 
%
% Import Image
% Get RGB K Means
% Get HSV K Means
% Get 5-Comp K Means
% Label
% Display image
%     
%--------------------------------------------------------------------------
%FUNCTIONS: 
%   rgb_kmeans
%   hsv_kmeans
%   loc_kmeans
%   label
%   funcolor
%NOTES: 
%**************************************************************************

image = im2double(imread('images/1.jpg')); %Convert to Double for processing


id_rgb = rgb_kmeans(image); 

id_hsv = hsv_kmeans(image,1); 

id_loc = loc_kmeans(image); %Version 1

labeled = label(id_loc); %Version 2: Change to hsv for hsv v2

labeled = label2rgb(labeled);

figure()

labeled = funcolor(id_loc,image); %Cartoon Image

imshow(labeled)

