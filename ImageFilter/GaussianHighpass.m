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
    figure(d0)
    imshow(image_filter_apply,[])
end 