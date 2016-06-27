function Binary

close all

for k=1:2
    if k == 1
        BW=imread('rectangle.bmp');  % read sample image       
    else    
        BW=imread('circle.bmp');     % read other sample image
    end
    
    % make a binary image from original image
    BW(BW<200)=0; 

    % conver to gray image
    BW = rgb2gray(BW);

    % get chain code with 4 neighboor
    chain_code_4 = getChainCodeFour(BW);

    % get chain code with 8 neighboor ( This is optional, if you don't need, please remove below row. )
    chain_code_8 = getChainCodeEight(BW);

    % normalize chain code with 4 neighboor
    normal_code = normalizeChainCode(chain_code_4);

    % different chain code with 4 neighboor
    diff_code_4 = diffChainCode(chain_code_4, 4);

    %ouput chain code (4 neighboor)
    if k == 1
        formatSpec = 'Rectangle 4 Chain code %dth : %s';     
    else    
        formatSpec = 'Circle 4 Chain code %dth : %s';         
    end
    [m n] = size(chain_code_4);
    for i=1:m
       for j=1:n       
            str = sprintf(formatSpec, i, chain_code_4{i,j});   
            disp(str);
       end
    end


    %ouput chain code (8 neighboor)    ( This is optional, if you don't need, please remove below row 46 ~ 57. )
    if k == 1
        formatSpec = 'Rectangle 8 Chain code %dth : %s';     
    else    
        formatSpec = 'Circle 8 Chain code %dth : %s';         
    end
    [m n] = size(chain_code_8);
    for i=1:m
       for j=1:n       
            str = sprintf(formatSpec, i, chain_code_8{i,j});   
            disp(str);
       end
    end


    %ouput mormal chain code (4 neighboor)
    if k == 1
        formatSpec = 'Rectangle Normal 4 Chain code %dth : %s';     
    else    
        formatSpec = 'Circle Normal 4 Chain code %dth : %s';         
    end
    [m n] = size(normal_code);
    for i=1:m
       for j=1:n       
            str = sprintf(formatSpec, i, normal_code{i,j});   
            disp(str);
       end
    end

    %ouput differential chain code (4 neighboor)
    if k == 1
        formatSpec = 'Rectangle Differential 4 Chain code %dth : %s';     
    else    
        formatSpec = 'Circle Differential 4 Chain code %dth : %s';         
    end
    [m n] = size(diff_code_4);
    for i=1:m
       for j=1:n       
            str = sprintf(formatSpec, i, diff_code_4{i,j});   
            disp(str);
       end
    end

    % calculate Fourier descriptor
    fourie_desc = getFourierDescriptor(BW);

    % display shape function
    getShapeDistribution(chain_code_8, 8, k);
end



end

% get chain code for 4-neighbor
function chain_code = getChainCodeFour(BW)
    [B,L,N,A] = bwboundaries(BW, 4); % B - boundary point array
    
    [m n] = size(B); % m - number of boundary object in image. n - 1
    chain_code = cell(m, n);
    for i=1:m
        for j=1:n
            code_serial = '';
            C = B{i, j};
            [r t] = size(C);       % r - number of boundary points,  t- 2
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

                if( x == prev_x ) % vertical direction
                    if( y > prev_y )
                        code = '3';
                    else    
                        code = '1';
                    end
                end
                code_serial = strcat(code_serial,code); % append chain code to string
                prev_x = x;
                prev_y = y;
            end
            chain_code{i, j} = code_serial;
        end        
    end
end

% get chain code for 8-neighbor
function chain_code = getChainCodeEight(BW)
    [B,L,N,A] = bwboundaries(BW, 8); % B - boundary point array
    
    [m n] = size(B);% m - number of boundary object in image. n - 1
    chain_code = cell(m, n);
    for i=1:m
        for j=1:n
            code_serial = '';
            C = B{i, j};
            [r t] = size(C); % r - number of boundary points,  t- 2
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
                
                if( x > prev_x && y < prev_y  ) % diagonal direction
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
                
                if( x == prev_x ) % vertical direction
                    if( y > prev_y )
                        code = '6';
                    else    
                        code = '2';
                    end
                end
                code_serial = strcat(code_serial,code); % append chain code to string
                prev_x = x;
                prev_y = y;
            end
            chain_code{i, j} = code_serial;
        end        
    end
end

% get normal chain code from chain code
function normal_code = normalizeChainCode(code_array)
    [m n] = size(code_array);
    
    normal_code = cell(m, n);
    for i=1:m
        for j=1:n
            code = code_array{i, j};
            k = strfind(code,'0');   % find "0" 
            [p q] = size(k);
            pos = k(1, 1);
            endpos = length(code);
        
            if( q > 0 )
                normal_code{i, j} = [code(pos:endpos) fliplr(code(1:(pos-1)))];  % normalize chain code
            end
        end
    end    
end 

% get differential chain code from chain code
function diff_code = diffChainCode(code_array, mode) % mode - 4 or 8 neighbor
    [m n] = size(code_array);
    
    diff_code = cell(m, n);
    for i=1:m
        for j=1:n
            code_serial = '';
            code = code_array{i, j};
            len = length(code);
            
            prev_value = str2num(code(len-1));   % convert code to number
            for k=1:len
                code_value = str2num(code(k));
                diff_value = mod(code_value - prev_value, mode);  % get difference               
                diff = num2str(diff_value);
                code_serial = strcat(code_serial,diff); % convert to string and append it
                
                prev_value = code_value;
            end
            diff_code{i, j} = code_serial;
        end
    end    
end

% get fourier descriptor from binary image
function f_code = getFourierDescriptor(BW)
    [B,L,N,A] = bwboundaries(BW, 8); % B - boundary points
    
    [m n] = size(B);
    f_code = cell(m, n);
    for i=1:m
        for j=1:n
            C = B{i, j};
            f_code{i,j} = frdescp(C); % get fourier descriptor
            
            %disp(f_code{i,j});            % if you need , remove remark,
                                           % then can output it.
        end        
    end
    
end

% get fourierdescriptor from object
function z = frdescp(s)
[np, nc] = size(s);
if nc ~= 2
    error('S must be of size np-by-2.')
end

if np/2 ~= round(np/2)
    s(end + 1, :) = s(end, :);
    np = np + 1;
end

x = 0:(np - 1);
m = ((-1) .^ x)';
s(:,1) = m .* s(:, 1);
s(:,2) = m .* s(:, 2);

s = s(:,1) + i * s(:, 2);
z = fft(s);  % perform fft

end

% get shape distribution from chain code
function getShapeDistribution(code_array, mode, num) % mode  - 4 or 8 neighbor, num - index of object
    [m n] = size(code_array);
    
    for i=1:m
        for j=1:n
            hist = zeros(mode, 1);
            code = code_array{i, j};
            len = length(code);
            
            if num == 1
                formatSpec = 'Rectangle Shape Distribution = %dth';     
            else    
                formatSpec = 'Circle Shape Distribution = %dth';     
            end
    
            str = sprintf(formatSpec, i);    
            figure('name', str);
            
            for k=1:len
                code_value = str2num(code(k)); 
                hist(code_value + 1) = hist(code_value + 1) + 1;
            end
            
            bar(hist);            
        end
    end    
end