function regionColor = regionPureColor(regionLevel, year)

    regionColor = struct;
    regionNumber = 1;

    for i=1:length(regionLevel)
        level = char(regionLevel{i});
        fileName = ['data/' level year '.txt'];
        fid = fopen(fileName,'rt');
        
        fgetl(fid); %discard the blank line

        while ~feof(fid)
            election = fgetl(fid); %the line that says USA or State Name        
            data = textscan(election, '%s %f %f %f ', 'delimiter', ',') 
            name = char(data{1,1});
            my_data = cell2mat(data(2:4));
            regionColor(regionNumber).regionName=[level '_' lower(name)];   
            x = my_data(1);
            y = my_data(2);
            z = my_data(3);
            [r, g, b] = getPurpleColor(x, y, z);
            regionColor(regionNumber).color = [r, g, b];
            regionNumber = regionNumber + 1
        end
        fclose(fid);
    end    


end

function [R, G, B] = getPrimaryColor(x, y, z)
    R = 1
    G = 0
    B = 0
end

function [R, G, B] = getPurpleColor(x, y, z)
    sum = x + y + z;
    R = x / sum;
    G = z / sum;
    B = y / sum;
end

