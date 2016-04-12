%  Simulation of Detector for Antipodal Signal

clear all ; close all;

E = 1 ;       % normalized to unit energy
snr_dB = 9;   % estimates for 9dB will be inaccurate
N = 21667;    % no of bits  ...
M = 45;       % massege len 

% STEP 1: simulate the source bits 0 or 1 ....
for i=1:N
   tt = rand;   %  tt is uniformly distributed in 0->1 .
 %  for j=1:M 
     % "MAT¡±and TAM" --> 011 000 101 101 000 011
     % Li Lee" and "Chim Sha Lew -> 011 010 011 001 001   000 010 010 011 101 010 000 011 001 110
     src(i*M+0) = 0 ; src(i*M+1) = 1 ; src(i*M+2) = 1 ; % 011
     src(i*M+3) = 0 ; src(i*M+4) = 1 ; src(i*M+5) = 0 ; 
     src(i*M+6) = 0 ; src(i*M+7) = 1 ; src(i*M+8) = 1 ; 
     src(i*M+9) = 0 ; src(i*M+10) = 0 ; src(i*M+11) = 1 ; 
     src(i*M+12) = 0 ; src(i*M+13) = 0 ; src(i*M+14) = 1 ; 
     
     src(i*M+15) = 0 ; src(i*M+16) = 0 ; src(i*M+17) = 0 ; 
     src(i*M+18) = 0 ; src(i*M+19) = 1 ; src(i*M+20) = 0 ; 
     src(i*M+21) = 0 ; src(i*M+22) = 1 ; src(i*M+23) = 0 ; 
     src(i*M+24) = 0 ; src(i*M+25) = 1 ; src(i*M+26) = 1 ; 
     src(i*M+27) = 1 ; src(i*M+28) = 0 ; src(i*M+29) = 1 ; 
     src(i*M+30) = 0 ; src(i*M+31) = 1 ; src(i*M+32) = 0 ; 
     src(i*M+33) = 0 ; src(i*M+34) = 0 ; src(i*M+35) = 0 ; 
     src(i*M+36) = 0 ; src(i*M+37) = 1 ; src(i*M+38) = 1 ; 
     src(i*M+39) = 0 ; src(i*M+40) = 0 ; src(i*M+41) = 1 ; 
     src(i*M+42) = 1 ; src(i*M+43) = 1 ; src(i*M+44) = 0 ; 
  % end
%   if (tt < 0.5)
%      src(i) = 0 ;
%  else
%     src(i) = 1 ;
%   end
end ;

% STEP 2a: simulate the noise parameters for correlator ..
snr = exp(snr_dB*log(10)/10) ;
sig = E/sqrt(2*snr) ;       % this is detector noise std deviation

% the detector signals and BER ....
err = 0 ;
for i=1:N*M
   n0 = sig*randn ;  % STEP 2b: WGN for correlator ..

   % Step 3: generate signal with noise
   if(src(i) == 0)
      r0(i) =  E + n0 ;  % if bit 0 is transmitted,
   else
      r0(i) = -E + n0 ;   % if bit 1 is transmitted
   end
   
   % Step 4a: Detector makes a decision on binary value based on signal value 
   if (r0(i) > 0)        
      bit = 0 ;
   else 
      bit = 1 ;
   end
   
   % Step 4b: if wrong bit detected, increment error counter by 1
   if (bit ~= src(i))    
      err = err + 1 ;
   end ;
end;
BER = err/(N * M) ; % Step 4c: calculate error rate

% calculate theoretical BER ...in a SNR (db) range
dbR = 0:10 ;
for i = 1:length(dbR)
   snr = exp(dbR(i)*log(10)/10) ;
   BERT(i) = 0.5*erfc(sqrt(snr)) ;   % theoretical BER
end ;

figure(1); plot(r0, zeros(1,N*M),'.', [0 0], [-0.3 0.3],'r--') ; % figure 1 plots 1:N matrix of zeros against r0, using dots. A red dashed line separates the plot
axis([-3 3 -0.5 0.5]); 
grid;
title('Signal constellations (normalized by Energy)');
xlabel('correlator-0 output');

figure(2); 
% semilogy(...) creates a plot using a base 10 logarithmic scale for the y-axis and a linear scale for the x-axis.
% BERT is plotted on y-axis and dbR on x-axis
% red * is plotted using snr_dB and BER values pair
semilogy(dbR, BERT, snr_dB, BER,'r*') ; 

grid ;
xlabel('SNR in dB');
ylabel('Bit Error Probability, Pb');
title('Theoretical (blue) and simulated (red *) Pb');
