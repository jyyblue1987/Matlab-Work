function Binary

close all

BW=imread('rectangle.bmp'); 

BW(BW<200)=0; 

BW = rgb2gray(BW);

chain_code_4 = getChainCodeFour(BW);
chain_code_8 = getChainCodeEight(BW);


end

function chain_code = getChainCodeFour(BW)
    [B,L,N,A] = bwboundaries(BW, 4);
    
    [m n] = size(B);
    chain_code = cell(m, n);
    for i=1:m
        for j=1:n
            code_serial = '';
            C = B{i, j};
            [r t] = size(C);
            prev_x = C(r-1, 1);
            prev_y = C(r-1, 2);
            for k=1:r-1
                x = C(k, 1);
                y = C(k, 2);
                code = '0';
                if( y == prev_y ) % horizontal direction
                    if( x > prev_x )
                        code = '0';
                    else    
                        code = '2';
                    end
                end

                if( x == prev_x ) % horizontal direction
                    if( y > prev_y )
                        code = '3';
                    else    
                        code = '1';
                    end
                end
                code_serial = strcat(code_serial,code);
                prev_x = x;
                prev_y = y;
            end
            chain_code{i, j} = code_serial;
        end        
    end
end

function chain_code = getChainCodeEight(BW)
    [B,L,N,A] = bwboundaries(BW, 8);
    
    [m n] = size(B);
    chain_code = cell(m, n);
    for i=1:m
        for j=1:n
            code_serial = '';
            C = B{i, j};
            [r t] = size(C);
            prev_x = C(r-1, 1);
            prev_y = C(r-1, 2);
            for k=1:r-1
                x = C(k, 1);
                y = C(k, 2);
                code = '0';
                if( y == prev_y ) % horizontal direction
                    if( x > prev_x )
                        code = '0';
                    else    
                        code = '4';
                    end
                end
                
                if( x > prev_x && y < prev_y  ) 
                    code = '1';                    
                end
                
                if( x < prev_x && y < prev_y  ) 
                    code = '3';                    
                end
                
                if( x < prev_x && y > prev_y  ) 
                    code = '5';                    
                end
                
                if( x > prev_x && y > prev_y  ) 
                    code = '7';                    
                end
                
                if( x == prev_x ) % horizontal direction
                    if( y > prev_y )
                        code = '6';
                    else    
                        code = '2';
                    end
                end
                code_serial = strcat(code_serial,code);
                prev_x = x;
                prev_y = y;
            end
            chain_code{i, j} = code_serial;
        end        
    end
end



