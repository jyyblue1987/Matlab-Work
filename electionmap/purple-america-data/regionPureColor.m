function regionColor = regionPureColor(fileName)
    fid = fopen(fileName,'rt');
    regionColor = struct;
    regionNumber = 1;

    fgetl(fid); %discard the blank line
    
    while ~feof(fid)
        election = fgetl(fid); %the line that says USA or State Name        
        data = textscan(election, '%s %f %f %f ', 'delimiter', ',') 
        name = data{1,1};
        my_data = cell2mat(data(2:4));
        regionColor(regionNumber).regionName=name        
        x = my_data(1)
        y = my_data(2)
        z = my_data(3)
        regionColor(regionNumber).color = getPurpleColor(x, y, z)
        regionNumber = regionNumber + 1
    end
    fclose(fid);


end

function [R, G, B] = getPrimaryColor(republicanVotes, democrateVotes, otherVotes)
    R = 1
    G = 0
    B = 0
end

function [R, G, B] = getPurpleColor(x, y, z)
    sum = x + y + z;
    R = x / sum;
    G = y / sum;
    B = z / sum;
end

