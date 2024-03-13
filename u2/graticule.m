function [XM, YM, XP, YP]=graticule(umin, umax, vmin, vmax, Du, Dv, du, dv, R, uk, vk, u0, proj)

%Create parallels
XP = []; YP = [];
for u  = umin:Du:umax
    %Longtitude of parallel points
    vp = vmin : dv : vmax;
    n = length(vp);
    up = repelem(u, 1, n);

    %Convert to oblique aspect
    [sp, dp] = uvTOsd(up, vp, uk, vk)
    
    %Project a parallel
    [xp, yp] = proj(R, sp, dp);

    % Add parallel to the listof parallels
    XP = [XP; xp];
    YP = [YP; yp];
end

%Create meridians
XM = []; YM = [];
for v  = vmin:Dv:vmax
    %Longtitude of meridian points
    um = umin : du : umax;
    n = length(um);
    vm = repelem(v, 1, n);

    %Convert to oblique aspect
    [sm, dm] = uvTOsd(um, vm, uk, vk)
    
    %Project a meridian
    [xm, ym] = proj(R, sm, dm);

    % Add meridian to the listof meridians
    XM = [XM; xm];
    YM = [YM; ym];
end

end