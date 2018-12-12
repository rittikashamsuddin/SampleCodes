%find class profiles
function [cp, already_added,en_label] = getClassProfile_32(num_clusters,fingerPrint,numAn,num_pat)


% initialize the profile structure
% since there are 4 base behaviors,
% there will be total of 32 profiles.
for i =1:num_clusters
    str=dec2bin(i-1,numAn);
    
    cp(i).nsq = zeros(1,numAn);
    
    % initialize the class profiles
    % with 1 for each combination of the base beahvior
    for k=1:numAn
        cp(i).nsq(k)=str2num(str(k));
    end
    cp(i).num= sum(cp(i).nsq);
    cp(i).en_id=[];
end

already_added = zeros(num_pat,numAn);
en_label = zeros(num_pat,1);

%incorporate the fingerprint from the first segment
% into class profile
for i =1:length(fingerPrint)
    fp= fingerPrint(i,:);  
   
    dis=100000;   
    for h=1:num_clusters
        if(cp(h).num)
            cp_c=cp(h).nsq/cp(h).num;
        else
            cp_c=cp(h).nsq;
        end
        
        %find the cluster seed that each fingerprint is closest to.
        [~,D] = knnsearch(cp_c,fp(1:numAn));
        if(dis>D)
            dis=D;
            predc=h;
        end
    end

   
    en_label(i) = predc;
    
    %update data structure
    cp(predc).num = cp(predc).num+1;
    
    cp(predc).nsq(1,:)=cp(predc).nsq(1,:)+ fp(1:numAn);
    cp(predc).en_id = [cp(predc).en_id,i];
    already_added(i,:)=fp(1:numAn);
end
end