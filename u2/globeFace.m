function[] = globeFace(umin, umax, vmin, vmax, Du, Dv, du, dv, R, uk, vk, u0, proj, ub, vb)

%Compute graticule
[XM, YM, XP, YP] = graticule(umin, umax, vmin, vmax, Du, Dv, du, dv, R, uk, vk, u0, proj);

%Plot graticule
hold on
plot(XM', YM', 'k');
plot(XP', YP', 'k');

%Compute continents
C = load('continents_points\eur.txt');
C = C * pi / 180;

%Plot continents
[XC, YC] = continents(C, R, uk, vk,u0, proj);
plot(XC', YC', 'b');

%Compute face boundary
[XB, YB] = boundary(ub, vb, R, uk, vk,u0, proj);

%Plot face boundary
plot(XB', YB', 'r');

axis equal;
end