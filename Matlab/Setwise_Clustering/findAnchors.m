%%% Uses heirarchical clustering to select the anchors
%%% In our case, the anchors are most distinct patterns in the dataset
function anchors = findAnchors(s_trimmed,numAn,selector_type,anchor_type)

    %%%% Choose between two kinds of features
    if(strcmp(selector_type,'Mo'))
        f_dorm = getFeatures(s_trimmed); % moment-based features
    else
       f_dorm=getDesctiptive(s_trimmed); %features: distribution of peak to peak distance
    end
    
    %heirarchical clustering
    [num_f,~]=size(f_dorm(1:(end-1),:));
    Z=linkage(f_dorm(1:(end-1),:)', 'complete', 'cityblock');
    c=cluster(Z,'maxclust',numAn);
    
    
    % find the centers of the clusters found
    % by heirarchical clustering
    cent=zeros(numAn,num_f);

    for i=1:numAn
        dit=f_dorm(1:(end-1),:)';
        ll=[];
        ll= (dit(find(c==i),:));
        [row,~]=size(ll);
        cent(i,:) = sum(ll)/row;
    end

    %round the center values
    % because features are discrete valued
    cent=round(cent);
    
    
    
    if(strcmp(anchor_type,'Mo'))      
       num_f=5;
    else
       num_f=8;
    end
    
    %find the pattern/segment in the dataset that is closest to
    % the calculated cluster centers
    anchors=zeros(numAn,num_f);
    for i=1:numAn
        [index,min_dist] = knnsearch(f_dorm(1:(end-1),:)',cent(i,:),'Distance','cityblock');
        disp(strcat('knnsearch min_dist:', num2str(min_dist)));
      
       figure;plot(s_trimmed(index).x);
        if(strcmp(anchor_type,'Mo'))
           t=getFeatures(s_trimmed);
           anchors(i,:)=t(1:num_f,index)';
        else
           t=getDesctiptive(s_trimmed);
           anchors(i,:)=t(1:num_f,index)';
        end
        
    end
    
end