function [bits] = header(h,w,QP,Frame_start,Frame_end)

bits = '';
bits = [bits dec2bin(h,16) dec2bin(w,16) dec2bin(QP,16),dec2bin(Frame_start,16) dec2bin(Frame_end,16)];