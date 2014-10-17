function [ labeled ] = label( input )
%%*************************************************************************
%  labeled = label(input)
%
% Description: This function returns the labeled K-Means 4 connected
%
% Input Arguments:
%	Name: input
%	Type: vector
%	Description: KMeaned Values
%
%
% Output Arguments:
%	Name: labeled
%	Type: vector
%	Description: Labeled KMeans
%
% 
% Coded by Nate
%*************************************************************************

 [x y] = size(input);

 s_vals = unique(input(find(input ~= 0)))
 labeled = zeros(x,y);
 n = length(s_vals);
 
 for i = 1:n

     temp = bwlabel((input == s_vals(i)),4)
     
     labeled = labeled + temp;
 end
 
end

