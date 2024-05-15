function [XM, YM, XP, YP] = graticule(umin, umax, vmin, vmax, Du, Dv, du, dv, R, uk, vk, u0, proj)

%Create parallels
XP = []; YP = [];
for u  = umin:Du:umax

    %Longtitude of parallel points
    vp = vmin : dv : vmax;

    %Equal latitude of parallel points
    n = length(vp);
    up = repelem(u, 1, n);

    %Convert to the oblique aspect
    [sp, dp] = uv_to_sd(up, vp, uk, vk);
    
    %Project a parallel
    [xp, yp] = proj(R, sp, dp, u0);

    %Add parallel to the list of parallels
    XP = [XP; xp];
    YP = [YP; yp];
end

%Create meridians
XM = []; YM = [];
for v  = vmin:Dv:vmax
    %Latitude of meridian points
    um = umin : du : umax;

    %Equal longitude of meridian points
    n = length(um);
    vm = repelem(v, 1, n);

    %Convert to the oblique aspect
    [sm, dm] = uv_to_sd(um, vm, uk, vk);
    
    %Project a meridian
    [xm, ym] = proj(R, sm, dm, u0);

    %Add meridian to the list of meridians
    XM = [XM; xm];
    YM = [YM; ym];
end

end