function [sr, dr] = uv_to_sd(ur, vr, ukr, vkr)
%Longitude difference
dvr = vkr-vr;

%Transformed latitude
sr = asin(sin(ur).*sin(ukr)+cos(ur).*cos(ukr).*cos(dvr));

%Transformed longitude (quadrant adjustment)
dr = -atan2(cos(ur).*sin(dvr),cos(ur).*sin(ukr).*cos(dvr)-sin(ur).*cos(ukr));