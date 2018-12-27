function cell2=Mirr_Interpol(a1,a2,s1,s2,e1,e2,MirrorActions,interpolatePoses)
% this is a pre process function that performs one or both of the tasks of
%  mirroring Poses , interpolating Poses,


global cell nEpisodes itrNum% dataset RightHandedSubjects  Njoints%TYPE
cell2=cell; X=[]; Y=[]; %hist3dsampleX=[]; hist3dsampleY=[];
%saveRSamples=1;
% ComEig=0; 
% if (strcmp(TYPE,'hist3D'))
%     ComEig=1;
% end
% if(exist(strcat(dataset,'eigvector.mat'),'file'))
%  ComEig=0;
% end

% if(exist(strcat(dataset,num2str(Njoints),'sampleX.mat'),'file'))
% saveRSamples=0;    
% end

ce=cell; nEpi=nEpisodes; ce2=cell2;it=itrNum;
parfor a=a1:a2
   [ce(a,:) ,ce2(a,:)]=partialMirr_Interpol(s1,s2,e1,e2,ce(a,:),nEpi,MirrorActions,interpolatePoses,it)
end

cell2=ce2;
cell=ce;
end

function [ce,ce2]=partialMirr_Interpol(s1,s2,e1,e2,ce,nEpi,MirrorActions,interpolatePoses,it)
ce2=ce;
 for s=s1:s2
        for e=e1:e2
         if(isempty(ce{1,(s-1)*nEpi+e})==0)
                               
                if(MirrorActions)
%                   output1=[output1; out];
%                   R=[-1 0 0; 0 1 0; 0 0 1]; 
%                   output2=[output2; out*R];
                  t=ce{1,(s-1)*nEpi+e};
                  t(:,:,1)=-t(:,:,1);
                  t(:,:,2)=-t(:,:,2);
                  ce2{1,(s-1)*nEpi+e}=t;        
                end
                 if(interpolatePoses)
                  t=ce{1,(s-1)*nEpi+e};
                  t=interpolate2(t,it);
                  ce{1,(s-1)*nEpi+e}=t;        
                  
                  t=ce2{1,(s-1)*nEpi+e};
                  t=interpolate2(t,it);
                  ce2{1,(s-1)*nEpi+e}=t;        
                  
                 end
                 

         end
         end     
end

end