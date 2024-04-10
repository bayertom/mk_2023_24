clc
clear

%Mercator projection, analyze properties

%Points on Equator
u1 = 29.684331560 * pi /180;
v1 = 80.508849717 * pi /180;
u2 = 26.518987534 * pi /180;
v2 = 87.948193690 * pi /180;

%Norhern-most and southern-most points
u3 = 29.228305677 * pi /180;
v3 = 84.187486225 * pi /180;

u4 = 27.510528731 * pi /180;
v4 = 82.769313061 * pi /180;

%Pole
vk = atan2(tan(u1)*cos(v2)- tan(u2)*cos(v1), tan(u2)*sin(v1)- tan(u1)*sin(v2))
uk = atan2(-cos(v2-vk),tan(u2))

%Transformation to oblique aspect
s1 = asin(sin(u1)*sin(uk)+cos(u1)*cos(uk)*cos(v1-vk));
s2 = asin(sin(u2)*sin(uk)+cos(u2)*cos(uk)*cos(v2-vk));
s3 = asin(sin(u3)*sin(uk)+cos(u3)*cos(uk)*cos(v3-vk));
s4 = asin(sin(u4)*sin(uk)+cos(u4)*cos(uk)*cos(v4-vk));

%True parallel
s0 = acos(2*cos(s3)/(1+cos(s3)))


%Scales
m1 = cos(s0) / cos(s1)
m2 = cos(s0) / cos(s2)
m3 = cos(s0) / cos(s3)
m4 = cos(s0) / cos(s4)

%Distorsions
ny1 = m1 - 1
ny2 = m2 - 1
ny3 = m3 - 1
ny4 = m4 - 1







