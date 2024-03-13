clc
clear

%WGS 84, parameters
a_WGS = 6378137.0000; 
b_WGS = 6356752.3142;
e2_WGS = (a_WGS*a_WGS - b_WGS*b_WGS)/(a_WGS*a_WGS);

%Point
phir_WGS = 50 * pi / 180;

%Local approximations (R = M)
W_WGS = sqrt(1-e2_WGS*(sin(phir_WGS))^2);
M_WGS = a_WGS*(1-e2_WGS)/W_WGS^3;
R1 = M_WGS;

%Local approximations (R = N)
N_WGS = a_WGS/W_WGS;
R2 = N_WGS;

%Local approximations (R = sqrt(M*N)
R3 = sqrt(M_WGS*N_WGS);

%Global approximations (R = a)
R4 = a_WGS;

%Global approximations (R = b)
R5 = b_WGS;

%Global approximations (R = (2a+b)/3)
R6 = (2*a_WGS + b_WGS)/3;

%Global approximations (Ve = Vs)
R7 =  (a_WGS^2 * b_WGS)^(1/3);

%Global approximations (Se = Ss)
R8 = b_WGS*(1 + 2 * e2_WGS/3 + 3 * e2_WGS^2/5 + 4 * e2_WGS^3 / 7 + 5 * e2_WGS^4/9);