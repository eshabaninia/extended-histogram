function [ e,output]=extendedHist2(input)
%global  dataset Njoints eigvectorL eigvectorR
e=0;    
% this fuction is used when type of histogram is hist3D
% we make extended histogram for every joint except hip center joint  (center of our coordinate system)
%     j=1;
%     for i=1:size(input,1) 
%         
%         currentPose(:,:)=input(:,i,:);
%         [temp(:,:,j) , nbin]=hist3d(currentPose,w);
%         j=j+1;
%         
%     end
% 
% 
%     [d1,d2,d3]=size(temp);
%     temp2=(reshape(temp,d1*d2,d3))';
% 
%     
% %load(strcat(dataset,'eigvector.mat'),'eigvector');
% if(RightOrLeftHanded==1)
%    temp2 =  temp2*eigvectorR(:,:);
% elseif(RightOrLeftHanded==2)
%     temp2 =  temp2*eigvectorL(:,:);
% end
%   if(UseInformativeJioints)
%       temp2=temp2*
%   end
%     



%     i=1;
%     while (i<=size(temp2,1))
%         if(min(temp2(i,:))==max(temp2(i,:)))
%             temp2=[temp2(1:i-1,:);temp2(i+1:end,:)];
%             i=i-1;
%         end
%         i=i+1;
%     end


    
    %[d1, d2]=size(temp2);
    [d1, d2]=size(input);
    if(d1<=d2)
        e=1;
        output={};
    else
        BIC=[];
        for it=1:3
            ncomponents=it;
            try
               obj{it} = fitgmdist(input,ncomponents,'Regularize',0.001);
            catch
                
                e=1;
                output={};
                return;
            end
            BIC=[BIC obj{it}.BIC];
        end
        if(isempty(BIC) )
            gggg=0;
        end
        [~, assoc_num_comp] = min(BIC);
        output=obj{assoc_num_comp};
    end
    
    