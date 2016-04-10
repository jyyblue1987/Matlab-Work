function  mapBoundaries = getBoundaryDataFromFile( fileName)
%reads from input file that contains geographic data and creates a
%structure array
%    Inputs: fileName is a string of the file that has the geographic data
%   Returns: mapBoundaries is the generated structure array with
%            field names regionName, longitude and latitude

fid = fopen(fileName,'rt');
mapBoundaries = struct;
regionNumber = 1;
levelNumber = 1;

region = {};
while ~feof(fid)
    nameRegion = fgetl(fid); %read name of region
    if ( nameRegion ~= -1 )
        regionLevel = fgetl(fid); %the line that says USA or State Name
        mapBoundaries(regionNumber).regionName = [regionLevel '_' lower(nameRegion)];
        
        indexOfRegion = find(ismember(region, regionLevel));
        if (isempty(indexOfRegion))
            region{levelNumber} = [regionLevel];
            levelNumber = levelNumber + 1;
        end                
        
        numPoints = str2num ( fgetl(fid) ); %number of points for this region
        for i=1:numPoints
            latLongLine = fgetl(fid);
            tokens = textscan(latLongLine, '%f', 'Delimiter', ' ', 'MultipleDelimsAsOne',1);  %split on whitespace
            mapBoundaries(regionNumber).longitude(i)=tokens{1}(1);
            mapBoundaries(regionNumber).latitude(i)=tokens{1}(2);
        end
        regionNumber = regionNumber + 1;
    end
    fgetl(fid); %discard the blank line
end
fclose(fid);

end

