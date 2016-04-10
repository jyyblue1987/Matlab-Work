function [R, G, B] = getPurpleColor(x, y, z)
    sum = x + y + z;
    R = x / sum;
    G = z / sum;
    B = y / sum;
end

