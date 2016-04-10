function [R, G, B] = getPrimaryColor(x, y, z)
    if x >= y && x >= z 
        R = 1;
        G = 0;
        B = 0;
    else if y >= x && y >= z 
        R = 0;
        G = 0;
        B = 1;
    else
        R = 0;
        G = 1;
        B = 0;
    end
end


