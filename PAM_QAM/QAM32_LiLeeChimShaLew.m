% MATLAB script 16-level QAM.
clear all; close all;
echo on
SNRindB1=0:2:20;      % snr per bit in db from 0 to 15, in multiples of 2
SNRindB2=0:0.1:20;    % snr per bit in db from 0 to 15, each value by a difference of 0.1
M=32;
k=log2(M);            % number of bits per symbol

for i=1:length(SNRindB1),
  smld_err_prb(i)=QAM32_LiLeeChimShaLew_Pe(SNRindB1(i));	% simulated error rate for each value from SNRindB1
  % Li Lee" and "Chim Sha Lew
  echo off;
end;
echo on ;

for i=1:length(SNRindB2),
  SNR=exp(SNRindB2(i)*log(10)/10);    	% signal-to-noise ratio
  
  % theoretical symbol error rate
  theo_err_prb_for_sqrtM_PAM(i)= (1-(1/sqrt(M)))*1.08*erfc(1.5*sqrt(3*k*SNR/((M-1)*2)));
  theo_err_prb(i) = 1 - ((1-theo_err_prb_for_sqrtM_PAM(i))^2);
  
  echo off ;
end;
echo on ;

% Plotting commands follow.
figure(floor(max(SNRindB1)/2)+2);
semilogy(SNRindB2,theo_err_prb,SNRindB1,smld_err_prb,'r*');
axis([-1 15 10^-7 1]);
xlabel('SNR per bit in dB');
ylabel('Symbol Error Probability, Pm');
title('Theoretical (blue) and simulated (red *) Pm');

echo off;