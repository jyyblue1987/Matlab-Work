
function feature = angularPartion(filename)
% Read Image
I = imread(filename);
%I = imread('16_right.jpeg');
% Resize image for easier computation

r = 500;
bin = 16;
B = imresize(I, [r r]);

% Read image
im = im2double(B);

[rows columns numberOfColorChannels] = size(im);

if numberOfColorChannels == 3 
    % Convert RGB to Gray via PCA
    lab = rgb2lab(im);
    f = 0;
    wlab = reshape(bsxfun(@times,cat(3,1-f,f/2,f/2),lab),[],3);
    [C,S] = pca(wlab);
    S = reshape(S,size(lab));
    S = S(:,:,1);
end


if numberOfColorChannels == 1 
    S = im;
end

gray = (S-min(S(:)))./(max(S(:))-min(S(:)));
%% Contrast Enhancment of gray image using CLAHE
J = adapthisteq(gray,'numTiles',[8 8],'nBins',128);
%% Background Exclusion
% Apply Average Filter
h = fspecial('average', [9 9]);
JF = imfilter(J, h);
%figure, imshow(JF)
% Take the difference between the gray image and Average Filter
Z = imsubtract(JF, J);
%figure, imshow(Z)
%% Threshold using the IsoData Method
level=isodata(Z); % this is our threshold level
%level = graythresh(Z)
%% Convert to Binary
BW = im2bw(Z, level + 0.003);

%% Remove small pixels
BW2 = bwareaopen(BW, 100);

figure, imshow(BW2);

%angular partition feature
cx = r / 2;
cy = r / 2;
hist = zeros(1, bin);
count = 0;
for i=1:r
    for j=1:r
        dx = j - cx;
        dy = i - cy;
        r2 = dx * dx + dy * dy;
        
        %check radius
        if( r2 > r * r / 4)
            continue;
        end
        
        count = count + 1;
        
        %calculate angle
        angle = atan2(dy, dx);
        if( angle < 0 ) 
            angle = angle + 2 * pi;
        end
        
        % calcuate partition number
        part = ceil(0.01 + angle / (2 * pi / bin));   
        if( part < 1 )
            part = 1;
        end
        
        if( part > bin )
            part = bin;
        end
        
        %countering forground pixel
        if( BW2(i, j) > 0 )
            hist(1, part) = hist(1, part) + 1;
        end
    end
end

%normalize hist
hist = hist / r;

% fft 
feature = abs(fft(hist));

end

%% Overlay
%BW2 = imcomplement(BW2);
%out = imoverlay(B, BW2, [0 0 0]);
%figure, imshow(out);









