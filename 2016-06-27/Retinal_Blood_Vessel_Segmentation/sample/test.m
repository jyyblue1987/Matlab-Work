close all

feature = zeros(6, 16);

feature(1,:) = angularPartion('R102.png');
feature(2,:) = angularPartion('R103.png');
feature(3,:) = angularPartion('R104.png');
feature(4,:) = angularPartion('R105.png');
feature(5,:) = angularPartion('R106.png');
feature(6,:) = angularPartion('R107.png');

dis = zeros(6, 6);
for i=1:6
    for j=i+1:6
        diff = feature(i,:) - feature(j,:);
        sv = diff.* diff;
        dp = sum(sv);   
        value = sqrt(dp);
        dis(i, j) = value;
    end
end

cluster = 3;
[idx,C] = kmeans(feature,cluster);

testfeature = angularPartion('R207.png');

result = zeros(1, cluster);

min = 100000;
min_index = 0;

for i =1:cluster
    diff = testfeature - C(i,:);
    sv = diff.* diff;
    dp = sum(sv);   
    value = sqrt(dp);
    result(1, i) = value;
    
    if value < min
        min = value;
        min_index = i;
    end
end

result
min_index

