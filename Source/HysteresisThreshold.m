
function BinaryEdgeImage = HysteresisThreshold(magnitudeImage,minThresh,maxThresh,sigma)

BinaryEdgeImage = magnitudeImage;
 [H,W]=size(magnitudeImage);
 size_of_kernel = 6*sigma+1;
%encode image based on threshold
for r=1+ceil(size_of_kernel/2):H-ceil(size_of_kernel/2)  
    for c=1+ceil(size_of_kernel/2):W-ceil(size_of_kernel/2)  
        if(BinaryEdgeImage(r,c)>=maxThresh) BinaryEdgeImage(r,c)=1;
        end
        if(BinaryEdgeImage(r,c)<maxThresh & BinaryEdgeImage(r,c)>=minThresh) BinaryEdgeImage(r,c)=2;
        end
        if(BinaryEdgeImage(r,c)<minThresh) BinaryEdgeImage(r,c)=0;
        end 
    end
end
 
 
 
vvvv = 1; 
 
while (vvvv == 1)
   
    vvvv = 0;
   
    for r=1+ceil(size_of_kernel/2):H-ceil(size_of_kernel/2)  
        for c=1+ceil(size_of_kernel/2):W-ceil(size_of_kernel/2)  
            if (BinaryEdgeImage(r,c)>0)      
                if(BinaryEdgeImage(r,c)==2) 
                   
                    % 8 neighborhood check
                    if( BinaryEdgeImage(r-1,c-1)==1 | BinaryEdgeImage(r-1,c)==1 | BinaryEdgeImage(r-1,c+1)==1 | BinaryEdgeImage(r,c-1)==1 |  BinaryEdgeImage(r,c+1)==1 | BinaryEdgeImage(r+1,c-1)==1 | BinaryEdgeImage(r+1,c)==1 | BinaryEdgeImage(r+1,c+1)==1 ) 
                        BinaryEdgeImage(r,c)=1;
                        vvvv == 1;
                    end
                end
            end
        end
    end
   
end
 
 
 
for r=1+ceil(size_of_kernel/2):H-ceil(size_of_kernel/2) 
    for c=1+ceil(size_of_kernel/2):W-ceil(size_of_kernel/2)  
        if(BinaryEdgeImage(r,c)==2) 
            BinaryEdgeImage(r,c)==0;
        end   
    end
end