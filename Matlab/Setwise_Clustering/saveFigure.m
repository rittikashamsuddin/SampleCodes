load('Data.mat');
cp_len=length(cp);

for i=1:cp_len
    s=strcat(skan,num2str(i));
    mkdir(s);
    numm=floor(.5*length(cp(i).en_id));
    indd=randperm(length(cp(i).en_id),numm);
    
    for j=1:length(indd)
        x=Data{cp(i).en_id(indd(j))}(:,2);
        %set(0,'DefaultFigureVisible','off')
        f=figure;
        plot(x);
        savefig(f,strcat(s,'/',num2str(j),'.fig'));
    end
end
close all;
%set(0,'DefaultFigureVisible','on')
% c=hgload('1.fig');
% k=hgload('2.fig');
% % Prepare subplots
% figure
% h(1)=subplot(1,2,1);
% h(2)=subplot(1,2,2);
% % Paste figures on the subplots
% copyobj(allchild(get(c,'CurrentAxes')),h(1));
% copyobj(allchild(get(k,'CurrentAxes')),h(2));