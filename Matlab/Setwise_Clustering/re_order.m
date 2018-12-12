%mix up the dataset, without messing up the temporal
% sequence of the segments for each fraction
function [re_or,y]= re_order(s)

%initialize data struct
for i=1:length(s)
    t(i).x=[];
    t(i).y=[];
    t(i).z=[];
    t(i).pid=[];
end

first_ind=zeros(1,160);


%find the first location
% of the first segment for each fraction
ppid=1;
for i=1:length(s)
    spid = s(i).pid;
    if(ppid==spid)        
        first_ind(ppid)= i;
        ppid=ppid+1;
                
    end
end


up_ind=first_ind;

% go through the dataset and use the first locations
% to find the next segment of each fraction 
count=1;
i=1;
while( i<=length(t))
    
    ind=mod(count,160);
    if(ind==0)
        ind=160;
    end
    count=count+1;

    if(up_ind(ind)>0)
        t(i)=s(up_ind(ind));

        if(ind<160)
            if(up_ind(ind)<(first_ind(ind+1)-1))
                up_ind(ind)=up_ind(ind)+1;
            else
                up_ind(ind)=-1;
            end
        else
            if(up_ind(160)<length(s))
                up_ind(ind)=up_ind(ind)+1;
            else
                up_ind(ind)=-1;
            end
        end
        i=i+1;
    end
    
end


% check that the number of segments for each fraction
% matches the original number
mat_ind=zeros(1,160);

for i=1:160
    count=0;
    for j=1:length(t)
        if(i==t(j).pid)
            count=count+1;
        end
    end
    
    if(i<160)
        mat_ind(i)= (first_ind(i+1)-first_ind(i))==count;
    else
        mat_ind(i)= (length(t)-first_ind(i)+1)==count;
    end
end
y=sum(mat_ind);
re_or=t;
end