close all

bin = 16;
galleryname = ['R102.png'; 'R103.png'; 'R104.png'; 'R105.png'; 'R106.png'; 'R107.png'];
[n m] = size(galleryname);

feature = zeros(n, bin);

for i=1:n
    filename = galleryname(i, :);
    feature(i,:) = angularPartion(filename);
end

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

input = 'R207.png';
testfeature = angularPartion(input);

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

for i=1:n
    if idx(i) == min_index
        matched = galleryname(i, :); 
        break;
    end
end
figure;
subplot(121);imshow(imread(input));title(['Input Image: ' input]);
subplot(122);imshow(imread(matched));title(['Matched Image: ' matched]);



