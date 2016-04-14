clc
clear
close all

% ==============================================================================
%            video watermarking using motion vectors and mode selection
% ==============================================================================

% ------------------------------------------------------------------------------
% Inputs
% ------------------------------------------------------------------------------

inputFile = 'video.mpg';

% Watermark label
L = [0 1 0 1 1 1 0 0 0 1 0 1 1 1 0 0]>0;  % Binary 0101110001011100
nL=length(L);

cmin = 25;                          % Minimum Index.
D = 40;                             % Minimum Energy.
n = 16;                             % Number of 8x8 Blocks to store a bit.
% Should be even


videoObj = VideoReader(inputFile);
nFrames = videoObj.NumberOfFrames;
mRows = videoObj.Height;
nColumns = videoObj.Width;



r = 1:8:mRows;
c = 1:8:nColumns;


NumOfBlocks=length(r)*length(c);
BlockForEncode=50;% Here you may select another block, 1<=BlockForEncode<=NumOfBlocks;



block_size=8;

lastFrame=nL+2;%If you want to encode all video, type here lastFrame=nFrames;
% ------------------------------------------------------------------------------
    f1=fullfile('Video'); % Name of Folder
    if (exist(f1) == 0) % Chk already Present
        mkdir (f1);        % Create if already not present 
    end
    
    %create the file name
    prefix='Video\';suffix='.png';
    file=[prefix,num2str(1),suffix];
    
    %Save the image file for first frame
    imwrite(rgb2gray(read(videoObj,1)),file,'PNG'); 
%% Encoding
h=waitbar(0,'Encoding');
for st=2:lastFrame
    
    IFrame = rgb2gray(read(videoObj,st));
    PFrame = rgb2gray(read(videoObj,st-1));
    if st==1
        imshow(IFrame)
        title('First Frame selected for watermarking')
    end
    
    
    
   recons_im=uint8(zeros(mRows,nColumns)); %initialize Reconstructed image 
   
   %Initialisation
    for i=1:block_size:mRows
        for j=1:block_size:nColumns
            Side_Info{st}(i,j).info='H.264';
        end
    end
    
    NumBit=0;
    for i=1:block_size:mRows
        for j=1:block_size:nColumns
            NumBit=NumBit+1;
            if st<=nL
                if NumBit==BlockForEncode
                    change=double(L(st-1))+1;% 1 or 2
                else
                    change=0;
                end
            else
                change=0;
            end
            [Side_Info{st}, blk_im]=Encode(Side_Info{st},PFrame,IFrame,recons_im,i,j,i, j,block_size,change); % Encoding & Watermarking
            recons_im(i:i+block_size-1,j:j+block_size-1)=blk_im; %Store Image
            
        end
    end
    
    %create the file name
    prefix='Video\';suffix='.png';
    file=[prefix,num2str(st),suffix];
    
    %Save the image file for each frame
    imwrite(recons_im,file,'PNG'); 
    
    waitbar(st/lastFrame)
end
close(h)

 %% Decoding
 h=waitbar(0,'Decoding');
 MessageRecovered=false(1,nL);
for st=2:lastFrame
    %create the files name
    prefix='Video\';suffix='.png';
    file1=[prefix,num2str(st),suffix];
    file0=[prefix,num2str(st-1),suffix];
    recons_im=imread(file1);
    PFrame=imread(file0);
    NumBit=0;
    for i=1:block_size:mRows
        for j=1:block_size:nColumns
            NumBit=NumBit+1;
            [blk_im]=decode(Side_Info{st},PFrame,recons_im,i,j,i,j,block_size); % Do Decoding
            decoded_im(i:i+block_size-1,j:j+block_size-1)=blk_im;% Store Image
            if st<=nL
                if NumBit==BlockForEncode
                    if strcmp(Side_Info{st}(i,j).prediction,'Intra')||strcmp(Side_Info{st}(i,j).prediction,'IPCM')
                        MessageRecovered(st-1)=false;
                    else
                        if Side_Info{st}(i,j).motion(1)<0
                            MessageRecovered(st-1)=true;
                        else
                            MessageRecovered(st-1)=false;
                        end
                    end
                end
            end
        end
    end
    
    
    if st==2
        figure;
        imshow(IFrame)
        figure;
        imshow(decoded_im)
    end
    waitbar(st/lastFrame)
end

close(h)