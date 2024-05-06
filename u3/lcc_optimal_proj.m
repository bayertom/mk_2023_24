clc
clear

%Lambert conformal conic projection, analyze properties
R = 6380000;

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

% Rho0
rho_n = 2*R*cos(s0)*cos(s1)*tan(s1/2+pi/4)^c
rho_d = c*(cos(s0)*tan(s0/2+pi/4)^c+cos(s1)*tan(s1/2+pi/4)^c)
rho0 = rho_n/rho_d

%Rho1, 2
rho1 = rho0*(tan(s0/2 + pi/4)/tan(s1/2 + pi/4))^c
rho2 = rho0*(tan(s0/2 + pi/4)/tan(s2/2 + pi/4))^c

%Scales
m1 = c*rho1/(R*cos(s1));
m2 = c*rho2/(R*cos(s2));
m0 = c*rho0/(R*cos(s0));

% Distortions
ny1 = m1 - 1;
ny2 = m2 - 1;
ny0 = m0 -1;

