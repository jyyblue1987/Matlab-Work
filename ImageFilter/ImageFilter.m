function ImageFilter

close all

%read image file
[a, map]=imread('Balloon.tif');

%convert gray 
a = rgb2gray(a);
figure('name', 'img1') 
imshow(a)

[m n]=size(a);

% run fft
f_transform=fft2(a);

% run shift for center
f_shift=fftshift(f_transform);

% show fft's magnitude
MF = abs(f_shift); % Get the magnitude
MF = log(MF+1); % Use log, for perceptual scaling, and +1 since log(0) is undefined
MF = mat2gray(MF); % Use mat2gray to scale the image between 0 and 1

figure('name', 'FFT Magnitude')
imshow(MF,[]); % Display the result

% show fft's phase
AF = angle(f_shift); % Get the phase
AF = mat2gray(AF); % Use mat2gray to scale the image between 0 and 1

figure('name', 'FFT Phase')
imshow(AF,[]); % Display the result

% create gausian low filter
p=m/2;
q=n/2;

d0=20;
for i=1:m
    for j=1:n
        distance=sqrt((i-p)^2+(j-q)^2);
        low_filter(i,j)=exp(-(distance)^2/(2*(d0^2)));
    end
end

% apply filter to fft image
filter_apply=f_shift.*low_filter;

% Perform inverse Fourier transform 
image_orignal=ifftshift(filter_apply);
image_filter_apply=abs(ifft2(image_orignal));

% displayed low filtered image
formatSpec = 'Lowpass Filter D0 = %d';
str = sprintf(formatSpec, d0);    
figure('name', str);    
imshow(image_filter_apply,[]);

% Create a Gaussian highpass filter 
for i=1:m
    for j=1:n
        distance=sqrt((i-p)^2+(j-q)^2);
        high_filter(i,j)=1-exp(-(distance)^2/(2*(d0^2)));
    end
end

% apply it to the Fourier coefficients of img1
filter_apply=f_shift.*high_filter;
image_orignal=ifftshift(filter_apply);
image_filter_apply=abs(ifft2(image_orignal));

% displayed highpass filtered image
formatSpec = 'Highpass Filter D0 = %d';
str = sprintf(formatSpec, d0);    
figure('name', str);    
imshow(image_filter_apply,[]);


% wavelet decompose
[cA1,cH1,cV1,cD1] = dwt2(a,'bior3.7');

figure('name', 'Wavelet cofficient')
colormap gray;

subplot(221)
imagesc(cA1); title('Lowpass Approximation');

subplot(222)
imagesc(cV1); title('Vertical Detail Image');

subplot(223)
imagesc(cH1); title('Horizontal Detail Image');

subplot(224)
imagesc(cD1); title('Diagonal Detail Image');

% set approximate subband to zero
[t y] = size(cA1);
subband = zeros(t, y);
Xsyn = idwt2(subband,cH1,cV1,cD1,'bior3.7');

figure('name', 'Reconstructed Wavelet Image');

colormap gray;
subplot(121); imagesc(a); title('Original Image'); 
axis square
subplot(122); imagesc(Xsyn); title('Edge map Image'); 
axis square

% show entropy
gray = 255 * (Xsyn-min(Xsyn(:))) ./ (max(Xsyn(:)-min(Xsyn(:))));
stats = graycoprops(uint8(gray))


aveDiff = mean2(diff(image_filter_apply - Xsyn))