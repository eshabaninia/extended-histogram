function hist=hist3d(currentPose,w)
%currentPose is a patch of poses with size nJoints*nFrames*3
% w is a a patch of weights with size nJoints*nFrames

Njoints=size(currentPose,1);
nbin=10;
hist(1:nbin,1:7,1:size(currentPose,2))=0;
x=reshape(currentPose(:,:,1),[],1);
y=reshape(currentPose(:,:,2),[],1);
z=reshape(currentPose(:,:,3),[],1);
[azimuth,elevation,r] = cart2sph(x,y,z);
% azimuth = atan2(y,x);
% elevation = atan2(z,sqrt(x.^2 + y.^2));
% r = sqrt(x.^2 + y.^2 + z.^2);
%[azimuth(:),elevation(:),r(:)] = cart2sph(currentPose(:,1),currentPose(:,2),currentPose(:,3));
if (isempty(w))
    w(1:size(r,1))=1;
end

%for i=1:size(r,1)
    t=(180/pi)*(-1*(elevation(:)-pi/2));
    j(1:size(t,1))=7;
    j(t<15)=1;
    j(t<45 & t>=15)=2;
    j(t<75 & t>=45)=3;
    j(t<105 & t>=75)=4;
    j(t<135 & t>=105)=5;
    j(t<165 & t>=135)=6;
    
%     if(t(:)<15)
%         j=1;
%     elseif (t<45)
%         j=2;
%     elseif (t<75)
%         j=3;
%     elseif (t<105)
%         j=4;
%     elseif (t<135)
%         j=5;
%     elseif(t<165)
%         j=6;
%     else
%         j=7;
%     end
    
    %k=1+floor(mod((azimuth(i)+pi),2*pi)/(30*pi/180));
    %ind2=1+floor((-1*(elevation(i)-pi/2))/(30*pi/180));
    
    k=1+floor(((azimuth(:)+pi)*(180/pi))/(360/nbin));
    k(k==nbin+1)=1;
    
    k=reshape(k,Njoints,[]);
    j=reshape(j,Njoints,[]);
    for n=1:size(k,2)
    for l=1:nbin
        for m=1:7
          hist(l,m,n)=tanh(sum((k(:,n)==l & j(:,n)==m).*(w(:,n)/max(w(:,n)))));
        end
    end
    end
    
%      if(isnan(k)==0 && isnan(j)==0)
%          if(k==nbin+1)
%          k=1;
%          
%          end
%       hist(k,j)=hist(k,j)+(w(i)/max(w));
%      end

%end
%showHoj3D(currentPose);
%hist = imnoise(hist,'gaussian',0,0.0001);