clc
clear

%Pole
uk = 50;
vk = 15;

ukr = uk * pi /180;
vkr = vk * pi /180;

%Input point, 1st quadrant
u = 40;
v = 10;

ur = u * pi /180;
vr = v * pi /180;

[s1, d1] = uv_to_sd(ur, vr, ukr, vkr);

%Input point, 2nd quadrant
u = 60;
v = 10;

ur = u * pi /180;
vr = v * pi /180;

[s2, d2] = uv_to_sd(ur, vr, ukr, vkr);

%Input point, 3rd quadrant
u = 60;
v = 20;

ur = u * pi /180;
vr = v * pi /180;

[s3, d3] = uv_to_sd(ur, vr, ukr, vkr);

%Input point, 4th quadrant
u = 40;
v = 20;

ur = u * pi /180;
vr = v * pi /180;

[s4, d4] = uv_to_sd(ur, vr, ukr, vkr);










