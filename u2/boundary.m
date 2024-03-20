function [XB, YB] = boundary(u, v, R, uk, vk,u0, proj)
%Transform to oblique aspect
[s, d] = uv_to_sd(u, v, uk, vk);

%Project continents
[XB,YB] = proj(R, s, d);

end