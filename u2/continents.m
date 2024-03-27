function [XC,YC] = continents(C, R, uk, vk,u0, proj)
%Project continents
u = C(:,1);
v = C(:,2);

%Transform to oblique aspect
[s, d] = uv_to_sd(u, v, uk, vk);

%Find points: s < s_min
s_min = 10 * pi /180;
idxs = find(s < s_min);

%Remove these points
s(idxs) = []; d(idxs) = [];

%Project continents
[XC,YC] = proj(R, s, d);

end





