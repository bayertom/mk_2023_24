function [X, Y] = stereo_proj(R, s, d)

psi0 = 0.0457874886968716;

%Reduce
psi = s - pi/2;

%Projection equation
rho = 2 * R * cos(psi0/2).^2 .* tan(psi/2);

%Polar to cartesian
X = -rho .* cos(d);
Y = rho .* sin(d);