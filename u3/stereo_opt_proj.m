clc
clear
format long g

%Pole
uk = 28.1358692*pi/180;
vk = 84.2819261*pi/180;

%Point on the boundary
u1 = 31.1749760*pi/180;
v1 = 81.8338118*pi/180;

%Convert u,v to s,d
[s1, d1] = uv_to_sd(u1, v1, uk, vk)

%Psi
psi1 = pi/2 - s1;

%Mju
mju= (2*cos(psi1/2)^2)/(1+cos(psi1/2)^2)

%Psi0
psi0 = 2*acos(sqrt(mju));

%Scales
m1 = (cos(psi0/2)/cos(psi1/2))^2;
mk = (cos(psi0/2)/cos(0))^2;
m = (cos(psi0/2)/cos(psi0/2))^2;

% Distortions
ny1 = m1 - 1;
nyk = mk - 1;
ny = m -1;
