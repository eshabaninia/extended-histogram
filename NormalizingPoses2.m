function NormalizingPoses2(rf,hf)
global cell nActions nSubjects nEpisodes  Njoints L1 L2 L3 L4 L5  shoulderCenter hipCenter hipLeft hipRight

nAct=nActions;nSub=nSubjects; nEpi=nEpisodes; 
c=cell; N=Njoints; sC=shoulderCenter; hC=hipCenter; hL=hipLeft; hR=hipRight; l1=L1; l2=L2; l3=L3; l4=L4; l5=L5 ;

parfor a=1:nAct
  
c(a,:)=partialNormalizePoses (nSub,nEpi,N, c(a,:),rf,hf,sC, hC, hL, hR,l1, l2, l3, l4, l5 )
end

cell=c;

end

function cell=partialNormalizePoses (nSub,nEpi,Njoints,cell,rf,hf,shoulderCenter, hipCenter, hipLeft, hipRight,L1, L2, L3, L4, L5 )
    for s=1:nSub
        for e=1:nEpi
        t=cell{1,(s-1)*nEpi+e}; 
        if(isempty(t)==0)
          
            [out,~,~,~,error]= poseNormalization2(t(:,:,1),t(:,:,2),t(:,:,3),rf,hf,shoulderCenter, hipCenter, hipLeft, hipRight,L1, L2, L3, L4, L5);
                if(error==0)
                t(:,:,1)=reshape(out(:,1),Njoints,[]); t(:,:,2)=reshape(out(:,2),Njoints,[]); t(:,:,3)=reshape(out(:,3),Njoints,[]); 
                cell{1,(s-1)*nEpi+e}=t;
                clear t
                else
                 cell{1,(s-1)*nEpi+e}=[]; 
                 clear t
                end
         end
        
            
                 
        end
        
    end
end

function [input, NX, NY ,NZ,error ]= poseNormalization2(X,Y,Z,rf,hf,shoulderCenter, hipCenter, hipLeft, hipRight,L1, L2, L3, L4, L5)
% rf=rotation flag   hf=height normalization flag

input=[]; error=0;
showFlag=0; % a flag for showing the result of oriantation normalization (not well developed)
NX=[]; NY=[]; NZ=[];

for s=1:size(X,2)
   S2=[X(:,s)-X(hipCenter,s) Y(:,s)-Y(hipCenter,s) Z(:,s)-Z(hipCenter,s)];
   %[S(:,1),S(:,2),S(:,3)] = cart2sph(S(:,1),S(:,2),S(:,3));
   
   if(sum(sum(isnan(S2)))>0)
        error=1;
        return;
    end
   
   if(sum(sum(S2==0))==size(X,1)*3)
        error=1;
        return;
    end
   if(rf==1)  
   S2=rotateInitToUp2(S2,shoulderCenter, hipCenter);
   if(sum(sum(S2==0))==size(X,1)*3)
        error=1;
   end
   if(sum(sum(isnan(S2)))>0)
        error=1;
        return;
   end
   S2=rotateUptoFront2(S2,hipLeft, hipRight);
    if(sum(sum(S2==0))==size(X,1)*3)
        error=1;
    end
    if(sum(sum(isnan(S2)))>0)
        error=1;
        return;
   end
   end
   
   if(hf==1)
    S2=normalizeHeight2(S2,L1, L2, L3, L4, L5, hipCenter);
    if(sum(sum(S2==0))==size(X,1)*3)
        error=1;
    end
  % showPose(S2);
  % pause(1/10);
   end
  
   
   if(sum(sum(isnan(S2)))>0)
        error=1;
        return;
   end
    
    S2=S2(:,1:3);
    input=[input; S2];
    NX=[NX S2(:,1)];
    NY=[NY S2(:,2)];
    NZ=[NZ S2(:,3)];
end
end