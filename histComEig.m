function [eigvectorL, eigvectorR]=histComEig()
%  computing Eigen vector of hist3d of poses (It is a version of ComEig2 especially for hist3d with lower speed but lower requiered memory)
global  AS ASind nActions nSubjects nEpisodes


global cell cell2 W RightHandedSubjects 
             
 asi=AS{ASind}; nSub=nSubjects;nEpi=nEpisodes; ce=cell;ce2=cell2;RHS=RightHandedSubjects; nAct=nActions;
 %w1=W(:,:,1); w2=W(:,:,2); 
 


 [binsampleXR, binsampleXL, binsampleY]=histAllsamples(nAct,nSub,nEpi,asi,RHS,ce,ce2);
 
 eigvectorR(70,1:max(binsampleY)-1)=0;
 eigvectorL(70,1:max(binsampleY)-1)=0;
                                
 options = [];
 options.Fisherface = 1;
 options.Regu=1;
 hist=bin2hist(binsampleXR,[]);
 hist=(reshape(hist,[],size(binsampleXR,1)))';
 %Y=(binsampleY==i);
 [eigvectorR(:,:), ~] = LDA(binsampleY, options,  hist);
 hist=bin2hist(binsampleXL,[]);
 hist=(reshape(hist,[],size(binsampleXR,1)))';
 [eigvectorL(:,:), ~] = LDA(binsampleY, options,  hist);


end

function hist=bin2hist(binsampleXR,w1)
nbin=10;
ns=size(binsampleXR,1);
binsampleXR=reshape(binsampleXR',2,[],ns);
k=reshape(binsampleXR(1,:,:),[],ns);
j=reshape(binsampleXR(2,:,:),[],ns);
 
if( isempty(w1)==0)
     weight=repmat((w1'/max(w1)),1,ns);
else
     weight=1;
end

hist(1:nbin,1:7,1:ns)=0;
    for l=1:nbin
        for m=1:7
          hist(l,m,:)=tanh(sum((k(:,:)==l & j(:,:)==m).*weight));
        end
    end
  
end

function [binsampleXR, binsampleXL, binsampleY]=histAllsamples(nAct,nSub,nEpi,asi,RHS,ce,ce2)


parfor a=1:nAct
 if (ismember(a,asi)) 
     [sampleXR{a},sampleXL{a},sampleY{a}]=histsamples(a,nSub,nEpi,ce(a,:),ce2(a,:),RHS);
 end
end

for a=1:nAct
szX(a)=size(sampleXR{a},1);
end

binsampleXR= zeros(sum(szX),size(sampleXR{1},2));
binsampleXL= zeros(sum(szX),size(sampleXL{1},2));
binsampleY=zeros(sum(szX),1);

indX=1;
for a=1:nAct
    
    binsampleXR(indX:indX+szX(a)-1,:)=sampleXR{a};
    binsampleXL(indX:indX+szX(a)-1,:)=sampleXL{a};
    binsampleY (indX:indX+szX(a)-1,:)=sampleY{a}; 
     
    indX=indX+szX(a);
end


end
function [binsampleXR,binsampleXL,binsampleY]=histsamples(a,nSub,nEpi,ce,ce2,RHS)

binsampleXR=[]; binsampleXL=[]; binsampleY=[];
 for s=1:nSub
        for e=1:nEpi
         if(isempty(ce{1,(s-1)*nEpi+e})==0)
                                                                                
                   t =ce{1,(s-1)*nEpi+e};
                   t2=ce2{1,(s-1)*nEpi+e};
                                            
                   if(ismember(s, RHS))
                     bins=hist3d2(t);
                     binsampleXR=[binsampleXR;(reshape(bins,[],size(t,2)))'];
                     bins=hist3d2(t2);
                     binsampleXL=[binsampleXL; (reshape(bins,[],size(t,2)))'];
                   else
                     bins=hist3d2(t);
                     binsampleXL=[binsampleXL;(reshape(bins,[],size(t,2)))'];
                     bins=hist3d2(t2);
                     binsampleXR=[binsampleXR;(reshape(bins,[],size(t,2)))'];
               
                   end
                     
                        % it is used for dimension reduction of his3d of all poese
              
                  
                   binsampleY=[binsampleY; repmat(a,size(t,2),1)]   ;
                   
  
         end
        end
 end
    
end

