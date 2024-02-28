clc
clear

%Vstupni body
phi_WGS = 50;
la_WGS = 15;

%Konverze, radiany
phir_WGS = phi_WGS*pi/180;
lar_WGS = la_WGS*pi/180;

%WGS 84, parametry
a_WGS = 6378137.0000; 
b_WGS = 6356752.3142;
e2_WGS = (a_WGS*a_WGS - b_WGS*b_WGS)/(a_WGS*a_WGS);
W_WGS = sqrt(1-e2_WGS*(sin(phir_WGS))^2);
N_WGS = a_WGS/W_WGS;

%Prostorove geocentricke souradnice
X_WGS =  N_WGS*cos(phir_WGS)*cos(lar_WGS);
Y_WGS =  N_WGS*cos(phir_WGS)*sin(lar_WGS);
Z_WGS =  N_WGS*(1-e2_WGS)*sin(phir_WGS);





