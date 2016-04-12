%  Simulation of Detector for Antipodal Signal

clear all ; close all;

d = 1 ;       % normalized to unit energy
snr_dB = 10; % estimates for 9dB will be inaccurate
N = 21667;    % no of bits  ...
M = 45;       % massege len 

% STEP 1: simulate the source bits 0 or 1 ....
for i=1:N*M
   tt = rand;   %  tt is uniformly distributed in 0->1 .
   if (tt < 0.125)
      src(i) = 0 ; % maps to 000
   elseif (tt < 0.25)
      src(i) = 1 ; % maps to 001
   elseif (tt < 0.375)
      src(i) = 2 ; % maps to 010
   elseif (tt < 0.5)
      src(i) = 3; % maps to 011
   elseif (tt < 0.625)
      src(i) = 4; % maps to 100
   elseif (tt < 0.75)
      src(i) = 5; % maps to 101
   elseif (tt < 0.875)
      src(i) = 6; % maps to 110
   elseif (tt < 1)
      src(i) = 7; % maps to 111
                          
   end
end ;

% STEP 2a: simulate the noise parameters for correlator ..
snr = exp(snr_dB*log(10)/10) ;
sig = d/sqrt(4*snr/5);       % this is detector noise std deviation

% the detector signals and BER ....
err = 0 ;
for i=1:N*M
   n0 = sig*randn ;  % STEP 2b: WGN for correlator ..

   % Step 3: generate signal with noise
   if(src(i) == 0)
      r0(i) =  -7*d + n0; % symbol 0
      r1(i) =  -7*d;
   elseif(src(i) == 1)
      r0(i) = -5*d + n0 ;   % symbol 1
      r1(i) = -5*d;
   elseif(src(i) == 2)
       r0(i) = -3*d + n0; % symbol 2
       r1(i) = -3*d;
   elseif(src(i) == 3)
       r0(i) = -d + n0; % symbol 3
       r1(i) = -d;
   elseif(src(i) == 4)
       r0(i) = d + n0; % symbol 3
       r1(i) = d;
   elseif(src(i) == 5)
       r0(i) = 3*d + n0; % symbol 3
       r1(i) = 3*d;
   elseif(src(i) == 6)
       r0(i) = 5*d + n0; % symbol 3
       r1(i) = 5*d;
   elseif(src(i) == 7)
       r0(i) = 7*d + n0; % symbol 3
       r1(i) = 7*d;
   end
   
   % Step 4a: Detector makes a decision on binary value based on signal value 
   if (r0(i) < -6*d)  % if amplitude <-2d
      symbol = 0 ;
   elseif (r0(i) < -4*d) % if amplitude between -2d and 0
      symbol = 1 ;
   elseif (r0(i) < -2*d) % if amplitude between 0 and 2d
       symbol = 2;
   elseif(r0(i) < 0)
       symbol = 3; % if amplitude >2d
   elseif (r0(i) < 2*d) % if amplitude between -2d and 0
       symbol = 4 ;
   elseif (r0(i) < 4*d) % if amplitude between 0 and 2d
       symbol = 5;
   elseif (r0(i) < 6*d)
       symbol = 6; % if amplitude >2d
   else (r0(i) < 8*d) % if amplitude between 0 and 2d
       symbol = 7;
   end
   
   % Step 4b: if wrong bit detected, increment error counter by 1
   if (symbol ~= src(i))    
      err = err + 1 ;
   end ;
end;
BER = err/(N*M) ; % Step 4c: calculate error rate

% calculate theoretical BER ...in a SNR (db) range
dbR = 0:20 ;
for i = 1:length(dbR)
   snr = exp(dbR(i)*log(10)/10) ;
   BERT(i) = 0.75*erfc(sqrt((2/5)*snr)) ;   % theoretical BER
end ;

figure(1); plot(r0, r1,'.')
hold on
plot([0 0], [-8 8], 'r--', [-2*d -2*d], [-8 8], 'r--', [2*d 2*d],[-8 8],'r--', [-4*d -4*d],[-8 8],'r--', [4*d 4*d],[-8 8],'r--', [-6*d -6*d],[-8 8],'r--', [6*d 6*d],[-8 8],'r--', [-8*d -8*d],[-8 8],'r--', [8*d 8*d],[-8 8],'r--') ; % figure 1 plots symbol against r0, using dots. Three red dashed lines separate the plot
axis([-10 10 -8 8]); 
grid;
title('Signal constellations (normalized by Amplitude)');
xlabel('correlator-0 output');

figure(2); 
% semilogy(...) creates a plot using a base 10 logarithmic scale for the y-axis and a linear scale for the x-axis.
% BERT is plotted on y-axis and dbR on x-axis
% red * is plotted using snr_dB and BER values pair
semilogy(dbR, BERT, snr_dB, BER,'r*') ; 

grid ;
xlabel('SNR in dB');
ylabel('Symbol Error Probability, Pb');
title('Theoretical (blue) and simulated (red *) Pb');

