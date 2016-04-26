function [h,w,QP,Frame_start,Frame_end,m] = dec_header(bits)

m = 1;

h = bin2dec(bits(m:m+15));
m = m + 16;
% disp(['Height=',num2str(h)]);

w = bin2dec(bits(m:m+15));
m = m + 16;
% disp(['Width=',num2str(w)]);

QP = bin2dec(bits(m:m+15));
m = m + 16;
% disp(['QP=',num2str(QP)]);


Frame_start = bin2dec(bits(m:m+15));
m = m + 16;
% disp(['Frame_start=',num2str(Frame_start)]);

Frame_end = bin2dec(bits(m:m+15));
m = m + 16;
% disp(['Frame_end=',num2str(Frame_end)]);
