function [p]=QAM32_LiLeeChimShaLew_Pe(snr_in_dB)
% [p]=QAM16_Pe(snr_in_dB)
%		QAM16_Pe  finds the probability of error via simulation for the given
%   		value of snr_in_dB, SNR in dB.
N=10000;
d=1;				  	% unit distance
M=32;
k=log2(M);              % number of bits per symbol
%K=30;

% STEP 1a: simulate the source symbols ....
for i=1:N,	
  temp=rand;			  	        % a uniform R.V. between 0 and 1
  dsource(i)=1+floor(M*temp);	  	% a number between 1 and 16, uniform 
%   for j=1:K 
%     % "MAT¡±and TAM" --> {01100 00000 10011 10011 00000 01100}. 
%     src(i*j+0) = 0 ; src(i*j+1) = 1 ; src(i*j+2) = 1 ; src(i*j+3) = 0 ; src(i*j+4) = 0 ; 
%     src(i*j+5) = 0 ; src(i*j+6) = 0 ; src(i*j+7) = 0 ; src(i*j+8) = 0 ; src(i*j+9) = 0 ;
%     src(i*j+10) = 1 ; src(i*j+11) = 0 ; src(i*j+12) = 0 ; src(i*j+13) = 1 ; src(i*j+14) = 1 ;
%     src(i*j+15) = 1 ; src(i*j+16) = 0 ; src(i*j+17) = 0 ; src(i*j+18) = 1 ; src(i*j+19) = 1 ;
%     src(i*j+20) = 0 ; src(i*j+21) = 0 ; src(i*j+22) = 0 ; src(i*j+23) = 0 ; src(i*j+24) = 1 ;
%     src(i*j+25) = 0 ; src(i*j+26) = 1 ; src(i*j+27) = 1 ; src(i*j+28) = 1 ; src(i*j+29) = 1 ;
%   end

end;

% STEP 1b: Mapping to the signal constellation follows.
mapping=[
     -3*d  5*d;                  % this is at position 1 (see slide 24), maps to 0010
	   -d  5*d;                     % this is at position 2, the rest follows in sequence...
        d  5*d;
	  3*d  5*d;
     -5*d  3*d;                  % this is at position 1 (see slide 24), maps to 0010
     -3*d  3*d;                  % this is at position 1 (see slide 24), maps to 0010
	   -d  3*d;                     % this is at position 2, the rest follows in sequence...
        d  3*d;
	  3*d  3*d;
      5*d  3*d;                  % this is at position 1 (see slide 24), maps to 0010
	 -5*d  d;
	 -3*d  d;
	   -d  d;
	    d  d;
	  3*d  d;
	  5*d  d;
 	 -5*d  -d; 
 	 -3*d  -d; 
	   -d  -d; 
	    d  -d;
      3*d  -d;
      5*d  -d;
	 -5*d  -3*d;
	 -3*d  -3*d;
	   -d  -3*d;
	    d  -3*d;
	  3*d  -3*d;                   % this is at position 16, maps to 1000
	  5*d  -3*d;                   % this is at position 16, maps to 1000
	 -3*d  -5*d;
	   -d  -5*d;
	    d  -5*d;
	  3*d  -5*d];                   % this is at position 16, maps to 1000
for i=1:N,
  qam_sig(i,:) = mapping(dsource(i),:);  % STEP 1c: copy all elements from row-dsource(i) of mapping to i-row of qam-sig (received signal)
end;

Eav=10*d^2;		 	  	        % energy per symbol - you should have computed this as instructed in slide 24
snr=10^(snr_in_dB/10);	 	  	% SNR per bit (NOT per symbol) - this is passed in a an argument from QAM16.m
sgma=sqrt(Eav/(2*k*snr));	  	  	% this is detector noise std deviation 
  
% Step 2: generate signal with noise n
for i=1:N,
  n(1) = sgma*randn ;
  n(2) = sgma*randn ;
  r(i,:)=qam_sig(i,:)+n;
end;

% detection and error probability calculation
numoferr=0;
for i=1:N,
  % Step 3a: Detector makes a decision on symbol (binary values) based on signal value
  
  % Distance, (Dr,sm) from slide 23, computation follows.
  % metrics store all distance values
  for j=1:M,
    metrics(j)=(r(i,1)-mapping(j,1))^2+(r(i,2)-mapping(j,2))^2;
  end;
  
  [min_metric decis] = min(metrics);   % min(metrics) returns the minimum value and corresponding index to min_metric and decis respectively
  
  % Step 3b: if wrong symbol detected, increment error counter by 1
  if (decis~=dsource(i)),
    numoferr=numoferr+1;
  end;
end;

for i=1:N,             % separate out the r1 and r2 values of each received signal r for plotting later
    r1(i)=r(i,1);
    r2(i)=r(i,2);
end;

figure(floor(snr_in_dB/2)+1);   % get figure number for each snr_in_dB, need to divide by 2 since snr_in_dB is given in multiples of 2
plot(r1,r2,'.');

% char function is used to obtain characters from snr_in_dB
title(['Signal constellations for SNR=',char(floor(snr_in_dB/10)+48),char(snr_in_dB-floor(snr_in_dB/10)*10+48)]);
p=numoferr/(N);		   % Step 3c: returns simulated symbol error rate