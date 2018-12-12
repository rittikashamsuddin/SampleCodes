%find fingerPrints for each fraction
function fingerPrint = findFP(sam_feature,anchors,num_pat,numAn,num_sam)

fingerPrint=zeros(num_pat,numAn+1);

for i=1:num_sam
        pt=sam_feature(1:(end-1),i)';
        en =sam_feature(end,i);
        
        fingerPrint(en,numAn+1) =  fingerPrint(en,numAn+1) +1;%update normalization constant
        pred = knnsearch(anchors,pt,'Distance','cityblock');
        
        fingerPrint(en,1:numAn)=fingerPrint(en,1:numAn)*(fingerPrint(en,numAn+1)-1);
        fingerPrint(en,pred) = fingerPrint(en,pred)+1;%update frequency by 1
        fingerPrint(en,1:numAn) = fingerPrint(en,1:numAn)/fingerPrint(en,numAn+1);
end
end