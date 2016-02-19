
function newMagnitudeImage = NonMaximalSuppression(magnitude,orientation, sigma)
[H,W]=size(magnitude);
size_of_kernel = 6*sigma+1;
newMagnitudeImage = magnitude;
for r=1+ceil(size_of_kernel/2):H-ceil(size_of_kernel/2) 
    for c=1+ceil(size_of_kernel/2):W-ceil(size_of_kernel/2)  
       
        %%quantize:
        if (orientation(r,c) == 0) tangent = 5;       
        else tangent = tan(orientation(r,c));   
        end
        if (-0.4142<tangent & tangent<=0.4142)
            if(magnitude(r,c)<magnitude(r,c+1) | magnitude(r,c)<magnitude(r,c-1))
                newMagnitudeImage(r,c)=0;
            end
        end
        if (0.4142<tangent & tangent<=2.4142)
            if(magnitude(r,c)<magnitude(r-1,c+1) | magnitude(r,c)<magnitude(r+1,c-1))
                newMagnitudeImage(r,c)=0;
            end
        end
        if ( abs(tangent) >2.4142)
            if(magnitude(r,c)<magnitude(r-1,c) | magnitude(r,c)<magnitude(r+1,c))
                newMagnitudeImage(r,c)=0;
            end
        end
        if (-2.4142<tangent & tangent<= -0.4142)
            if(magnitude(r,c)<magnitude(r-1,c-1) | magnitude(r,c)<magnitude(r+1,c+1))
                newMagnitudeImage(r,c)=0;
            end
        end
    end
end
