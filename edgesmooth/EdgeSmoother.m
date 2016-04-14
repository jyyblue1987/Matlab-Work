[image, map, alpha] = imread('shirt_1.png');

h = fspecial('motion', 50, 45);

Iblur = imfilter(image, h);

f = imshow(Iblur);

set(f, 'AlphaData', alpha);

imwrite(uint8(Iblur), 'result.bmp');


