function F=sepratePoses(currentPose,w)
global  Njoints
% x=reshape(currentPose(:,:,1),[],1);
% y=reshape(currentPose(:,:,2),[],1);
% z=reshape(currentPose(:,:,3),[],1);
% F=reshape([x y z]',[],3*Njoints);
currentPose=permute(currentPose,[3,1,2]);
F=(reshape(currentPose,[],size(currentPose,3)))';