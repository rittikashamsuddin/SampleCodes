%%% Implements modified Setwise Clustering
function [cp,fingerPrint] = Mom_Fp32Cp_E_S(s_trimmed)


%%%%%%%%%%%%%%Paramerters to method %%%%%%%%%%%%%%%
numAn =5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%Find anchors/base beahviors%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

anchors = findAnchors(s_trimmed,numAn,'Des','Mo');

%%%%%%%%%%%%%%%%%%%%%Find Init fingerPrints and Class Profiles%%%%%%%%%

%dataset has 160 fractions
num_sam=160;
sam_ind=1:160;

%test_data:: change the order of segments in the dataset, but preserving
%tmeporal consistency
[test_data,y]=re_order(s_trimmed);
disp(strcat('@@@@@@@@@',num2str(y)))% check point
sam_data = test_data(sam_ind);%get the first segment of each fraction

test_data(sam_ind)=[];

sam_feature = getFeatures(sam_data);% turn segments to features

% find the initial fingerPrints
fingerPrint = findFP(sam_feature,anchors,num_sam,numAn,num_sam);

%use temlate based seeding to initialize the patient profiles
num_clusters = 32; 
[cp, already_added,en_label] = getClassProfile_32(num_clusters,fingerPrint,numAn,num_sam);


%%%%%%%%%%%%%%%%%%%%%Cluster the rest of the data%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:length(test_data)
    i
    sam_data=[sam_data,test_data(i)];
    
    sam_feature = getFeatures(sam_data);% since feature depends on distribution seen so far
                                        % the distibution is updated every
                                        % time we see a data point
    ptf1=sam_feature(:,end);
    ptf=ptf1(1:(end-1))';
    en=ptf1(end);
    
    %update fingerPrints as necessary
    fingerPrint(en,numAn+1) =  fingerPrint(en,numAn+1) +1;
    preda = knnsearch(anchors,ptf,'Distance','cityblock');
    fingerPrint(en,1:numAn)=fingerPrint(en,1:numAn)*(fingerPrint(en,numAn+1)-1);
    fingerPrint(en,preda) = fingerPrint(en,preda)+1;
    fingerPrint(en,1:numAn) = fingerPrint(en,1:numAn)/fingerPrint(en,numAn+1);
    
    %update class profile as necessary
    dis=100000;   
    for h=1:num_clusters
        if(cp(h).num)
            cp_c=cp(h).nsq/cp(h).num;
        else
            cp_c=cp(h).nsq;
        end
        
        [~,D] = knnsearch(cp_c,fingerPrint(en,1:numAn));
        if(dis>D)
            dis=D;
            predc=h;
        end
    end
    
    % allow fingerPrints to change class profile membership
    % as the clustering conitues
    if(en_label(en)==predc)
        cp(predc).nsq(1,:)=cp(predc).nsq(1,:)+fingerPrint(en,1:numAn) - already_added(en,:);
    else
        cp(en_label(en)).num = cp(en_label(en)).num-1;
        cp(en_label(en)).nsq(1,:)=cp(en_label(en)).nsq(1,:) - already_added(en,:);
        cp(en_label(en)).en_id(find(cp(en_label(en)).en_id==en))=[];

        cp(predc).num=cp(predc).num+1;
        cp(predc).nsq(1,:)=cp(predc).nsq(1,:)+ fingerPrint(en,1:numAn);
        cp(predc).en_id=[cp(predc).en_id,en];
        en_label(en)=predc;
   end 
   already_added(en,:)=fingerPrint(en,1:numAn);

end

end