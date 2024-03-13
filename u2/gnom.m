function [x,y] = gnom(R, sr, dr)
%Gnomonic projection
x = R .* tan (pi/2 - sr) .* cos (dr);
y = R .* tan (pi/2 - sr) .* sin (dr);