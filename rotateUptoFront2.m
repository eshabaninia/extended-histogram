function S2=rotateUptoFront2(S,hipLeft, hipRight)



%A=[S(head,1) S(shoulderCenter,1) S(shoulderLeft,1) S(shoulderRight,1)  S(hipCenter,1) S(hipLeft,1) S(hipRight,1);
%    S(head,2) S(shoulderCenter,2) S(shoulderLeft,2) S(shoulderRight,2)  S(hipCenter,2) S(hipLeft,2) S(hipRight,2);     
%    S(head,3) S(shoulderCenter,3) S(shoulderLeft,3) S(shoulderRight,3)  S(hipCenter,3) S(hipLeft,3) S(hipRight,3);
%    1         1                   1                 1                   1              1            1          ]';  

   V=(S(hipLeft,:)-S(hipRight,:))'; 
   V(3)=0;
    p=V/norm(V);
     if(p(1)==-1 && p(2)==0 && p(3)==0)
        S2=S;
     else
        teta=acos((p'*[-1;0;0])/norm(p));
        x=cross(p,[-1;0;0]);
        x=x/norm(x);
        R=[1 0 0; 0 1 0; 0 0 1].*cos(teta)+[0 -x(3) x(2); x(3) 0 -x(1); -x(2) x(1) 0].*sin(teta)+(1-cos(teta)).*(x*x');
    %   R=[R, [0 0 0]'];
    %   R=[R; [0 0 0 1]];
    
        S2=R*S';
        S2=S2';
     end
     
   if(sum(isnan(S2))>0)
         errror=1;
   end
     %% showing the result 
%      if (showFlag==1)
%      S=S2;
%      J =[L1 L2 L3 L4 L5];  
%      figure(1); h=plot3(S(:,1),S(:,2),S(:,3),'r.');
%      set(gca,'DataAspectRatio',[1 1 1]);
%      %axis([0 400 0 400 0 400])
%      for j=1:Njoints-1
%      c1=J(1,j);
%      c2=J(2,j);
%      line([S(c1,1) S(c2,1)], [S(c1,2) S(c2,2)], [S(c1,3) S(c2,3)]);
%      end
%      pause(1/20)
% 
%     
%      A=[S2(head,1) S2(shoulderCenter,1) S2(shoulderLeft,1) S2(shoulderRight,1) S2(hipRight,1) S2(hipLeft,1) S2(hipCenter,1);
%         S2(head,2) S2(shoulderCenter,2) S2(shoulderLeft,2) S2(shoulderRight,2) S2(hipRight,2) S2(hipLeft,2) S2(hipCenter,2);     
%         S2(head,3) S2(shoulderCenter,3) S2(shoulderLeft,3) S2(shoulderRight,3) S2(hipRight,3) S2(hipLeft,3) S2(hipCenter,3);
%         1 1 1 1 1 1 1];  
% 
%   % [~,~,V] = svd(A','econ');
%    [V,~,x] = affine_fit(A(1:3,:)');
%    V=V/norm(V);
% hold on;  plane(A(1,:),A(2,:),A(3,:),[V' -(V(1)*x(1)+V(2)*x(2)+V(3)*x(3))],'4planeParams');
%      end
ttttt=1;


