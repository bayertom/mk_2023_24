clc
clear

%Lambert conformal conic projection, analyze properties

%Pole
uk = 47.54283 * pi /180;
vk = 92.75077 * pi /180;

%Norhern-most and southern-most points
u1 = 30.3034211 * pi /180;
v1 = 82.1728161 * pi /180;

u2 = 27.4860294 * pi /180;
v2 = 82.7465284 * pi /180;

%Transformation to oblique aspect
s1 = asin(sin(u1)*sin(uk)+cos(u1)*cos(uk)*cos(v1-vk));
s2 = asin(sin(u2)*sin(uk)+cos(u2)*cos(uk)*cos(v2-vk));

%Constant values
num = log(cos(s1)) -log(cos(s2));
denom = log(tan(s2/2 +pi/4)) - log(tan(s1/2 +pi/4));
c = num/denom;
s0 = asin(c);



