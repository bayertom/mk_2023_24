function [s, d] = uv_to_sd(u, v, uk, vk)
%Longitude difference
dv = vk - v;

%Transformed latitude
s = asin(sin(u).*sin(uk)+cos(u).*cos(uk).*cos(dv));

%Transformed longitude (quadrant adjustment)
d = atan2(cos(u).*sin(dv),cos(u).*sin(uk).*cos(dv)-sin(u).*cos(uk));

end