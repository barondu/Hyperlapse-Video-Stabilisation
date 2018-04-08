function holder_model = ransacRigid(matchedPoints1, matchedPoints2)
    holder_model = [];
    holder_perc = 0;
    holder_diff = 0;
    for ran = 1:200
        %Do RANSAC steps here
        index_st = randperm(size(matchedPoints1,1),4);

        pnt1 = matchedPoints1(index_st, :);
        pnt2 = matchedPoints2(index_st, :);      

        model = rigidTransform(pnt1, pnt2);

        
        [x,y] = transformPointsForward(affine2d(model'), matchedPoints1.Location(:,1),...
            matchedPoints1.Location(:,2)); 

        distx = (x - matchedPoints2.Location(:,1)).^2;
        disty = (y - matchedPoints2.Location(:,2)).^2;

        diff = distx + disty;

        threshold = 50;
        percentage = mean(diff<threshold); %Percentage of inliers

        if(percentage >holder_perc)
            holder_perc = percentage;
            holder_model = model;
            holder_diff = diff;
        end
    end

end