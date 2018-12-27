
function [ e,output]=ParalelHEH4(input,RightOrLeftHanded,hirarchialLevels, TYPE ,eigvectorL, eigvectorR)
%global hirarchialLevels TYPE  Njoints NquassianCompo eigvectorL eigvectorR

if(RightOrLeftHanded==1)
   eigvector =  eigvectorR;
elseif(RightOrLeftHanded==2)
   eigvector =  eigvectorL;
end
nFrames=size(input,2);
if(strcmp(TYPE,'hist3D'))


inputs=reshape(hist3d(input,[]),[],nFrames)'*eigvector;
else
     inputs=sepratePoses(input,[])*eigvector;
end

%bin=[];
E(1)=0; %epsi=0.01;
for i=2:nFrames
   startind1=(i-1)+1; endind1=startind1-1;
   startind2=(i-2)+1; endind2=startind2-1;
    E(i)= E(i-1)+ sum(mynorm(input(:,i,:)-input(:,i-1,:),2));
end


tempPYRind(1:hirarchialLevels,1:2^(hirarchialLevels-1)+3)=0;
E=E/E(end);
 mid=1;
  for l=1:hirarchialLevels
   tempPYRind(l,1)=1;
   j=2;
   endPoint=mid;
   while (j<=(2^(l-1)))
       ind=find(E>=endPoint);
       tempPYRind(l,j)=ind(1);   
       endPoint=endPoint+mid;
        j=j+1;
   end
   
   tempPYRind(l,j)=size(input,2);
   mid=mid/2;
   J=j+1;
  end 
  
%   
% hulfind=-1; quadind=-1; threequadind=-1; eightind=-1; threeeightind=-1; fiveeightind=-1; seveneightind=-1;
% for i=1:size(E,2)
%     E(i)=E(i)/E(end);
%     if(E(i)>=0.5 && hulfind<0)
%         hulfind=i;
%     end
%     
%      if(E(i)>=0.25 && quadind<0)
%         quadind=i;
%      end
%     
%      if(E(i)>=0.75 && threequadind<0)
%         threequadind=i;
%      end
%     
%     if(E(i)>=0.125 && eightind<0)
%         eightind=i;
%     end
%      
%      if(E(i)>=3*0.125 && threeeightind<0)
%         threeeightind=i;
%      end
%      
%      if(E(i)>=5*0.125 && fiveeightind<0)
%         fiveeightind=i;
%      end
%      
%      if(E(i)>=7*0.125 && seveneightind<0)
%         seveneightind=i;
%      end
% end
% tempPYRind(1:4,1:10)=0;
% tempPYRind(1,1)=1; tempPYRind(1,2)=size(input,1);
% tempPYRind(2,1)=1; tempPYRind(2,2)=hulfind*Njoints; tempPYRind(2,3)=size(input,1);
% tempPYRind(3,1)=1; tempPYRind(3,2)=quadind*Njoints; tempPYRind(3,3)=hulfind*Njoints; tempPYRind(3,4)=threequadind*Njoints; tempPYRind(3,5)=size(input,1); 
% tempPYRind(4,1)=1; tempPYRind(4,2)=eightind*Njoints; tempPYRind(4,3)=quadind*Njoints;tempPYRind(4,4)=threeeightind*Njoints;tempPYRind(4,5)=hulfind*Njoints; tempPYRind(4,6)=fiveeightind*Njoints; tempPYRind(4,7)=threequadind*Njoints; tempPYRind(4,8)=seveneightind*Njoints; tempPYRind(4,9)=size(input,1); 

l=1; e=0;
output={};

ind=1;
while(l<=hirarchialLevels)
    k=2;
    while (tempPYRind(l,k)~=0)
        ttemp=inputs(tempPYRind(l,k-1):tempPYRind(l,k),:);

           [e1,o]=extendedHist2(ttemp);
        
       % bin=[bin b];
        output{ind}=o; ind=ind+1;
        e=or(e,e1);
        
        k=k+1;
    end
    l=l+1;
end

if(e==1)
    output={};
else
    if(size(output)==0)
        dddddddddd=0;
    end
  %  output=output{2:end};
end