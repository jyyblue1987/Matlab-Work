function GaussianHighpass
a=imread('Lenna.png');
a = rgb2gray(a);
figure(1)
imshow(a)
[m n]=size(a);
f_transform=fft2(a);
f_shift=fftshift(f_transform);
p=m/2;
q=n/2;

var = [10, 30, 50, 70];

imwrite(a, 'original.tif');
for k = 1:4
    d0=var(k);    
    for i=1:m
        for j=1:n
            distance=sqrt((i-p)^2+(j-q)^2);
            low_filter(i,j)=1-exp(-(distance)^2/(2*(d0^2)));
        end
    end
    filter_apply=f_shift.*low_filter;
    image_orignal=ifftshift(filter_apply);
    image_filter_apply=abs(ifft2(image_orignal));
    
    formatSpec = 'Highpass Filter D0 = %d';
    str = sprintf(formatSpec, var(5-k))    
    figure('name', str)    
    imshow(image_filter_apply,[])
    
    formatSpec = 'Highpass Filter_D0 = %d.bmp';
    str = sprintf(formatSpec, var(5-k))        
    imwrite(uint8(image_filter_apply), str)
end 