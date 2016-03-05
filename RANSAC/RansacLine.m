% Do not change the function name. You have to write your code here
% you have to submit this function
function lines = RansacLine(edgeImageIn, noIter, fitDistance, noPts, minD)


    % get the image size
    [M, N] = size(edgeImageIn);
    % Get coordinates of all of the pixel locations corresponding to an edge
    edgeInd = find(edgeImageIn);
    [eIi, eIj] = ind2sub([M N], edgeInd);

    % ----------------------------------- % 
    % -You have to write your code here-- %
    % ----------------------------------- % 

    lines = ones(9, 3);
    for i = 1 : 9
        pts = transpose([eIj, eIi]);

        [t,r] = ransacfitline(pts,noIter,fitDistance,noPts, minD);

        k1 = -tan(t);
        b1 = r/cos(t);

        lines(i, 1) = 1 / b1;
        lines(i, 2) = -k1 / b1;
        lines(i, 3) = 1;
    end
    
end

function [ theta,rho ] = ransacfitline( pts,iterNum,thDist,noPts, minD )
    %RANSAC Use RANdom SAmple Consensus to fit a line
    %	RESCOEF = RANSAC(PTS,ITERNUM,THDIST,NOPTS) PTS is 2*n matrix including 
    %	n points, ITERNUM is the number of iteration, THDIST is the inlier 
    %	distance threshold and ROUND(THINLRRATIO*SIZE(PTS,2)) is the inlier number threshold. The final 
    %	fitted line is RHO = sin(THETA)*x+cos(THETA)*y.

    sampleNum = 2;
    ptNum = size(pts,2);
    thInlr = noPts;
    inlrNum = zeros(1,iterNum);
    theta1 = zeros(1,iterNum);
    rho1 = zeros(1,iterNum);

    for p = 1:iterNum
        % 1. fit using 2 random points
        
        sampleIdx = randIndex(ptNum,sampleNum);
        ptSample = pts(:,sampleIdx);
        d = ptSample(:,2)-ptSample(:,1);
       
        % check distance two points
        if norm(d) < minD
            continue;
        end
        
        d = d/norm(d); % direction vector of the line
       
        % 2. count the inliers, if more than thInlr, refit; else iterate
        n = [-d(2),d(1)]; % unit normal vector of the line
        dist1 = n*(pts-repmat(ptSample(:,1),1,ptNum));
        inlier1 = find(abs(dist1) < thDist);
        inlrNum(p) = length(inlier1);
        
        % check inliner count
        if length(inlier1) < thInlr, continue; end
        
        % implement PCA to get direction vector angle
        ev = princomp(pts(:,inlier1)');
        d1 = ev(:,1);
        theta1(p) = -atan2(d1(2),d1(1)); % save the coefs
        rho1(p) = [-d1(2),d1(1)]*mean(pts(:,inlier1),2);
    end

    % 3. choose the coef with the most inliers
    [~,idx] = max(inlrNum);
    theta = theta1(idx);
    rho = rho1(idx);

end


function index = randIndex(maxIndex,len)
    %INDEX = RANDINDEX(MAXINDEX,LEN)
    %   randomly, non-repeatedly select LEN integers from 1:MAXINDEX

    if len > maxIndex
        index = [];
        return
    end

    index = zeros(1,len);
    available = 1:maxIndex;
    rs = ceil(rand(1,len).*(maxIndex:-1:maxIndex-len+1));
    for p = 1:len
        while rs(p) == 0
            rs(p) = ceil(rand(1)*(maxIndex-p+1));
        end
        index(p) = available(rs(p));
        available(rs(p)) = [];
    end
end
