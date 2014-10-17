function [ o ] = tests( img )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

[a b] = size(img);
o = zeros(a,b);
for i=40:40:a
    for j=30:30:b
        t = sum(var(double(img((i-39):i,(j-29):j))));
        o((i-39):i,(j-29):j) = t;
    end
end




end

