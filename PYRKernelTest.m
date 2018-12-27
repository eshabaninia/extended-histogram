function K=PYRKernelTest(X,Y,type,sigma,hirarchialLevels )
% type is 1 or 2. in case 1, it shows that X,Y are vectors of integer
% values representing mean and std of bins. while in case 2, it shows that
% X, Y represent vectors of gmm distributions.

%sigma = 1;
N=size(X,2)/(2^(hirarchialLevels)-1);
K=zeros(size(X,1),size(Y,1));
if(type==1)
    ind=1;
    for l=1:hirarchialLevels
        w=1/(2^(hirarchialLevels-l));
        for j=1:2^(l-1)
            K=K+ w.*exp(-sigma .* pdist2(X(:,ind:ind+N-1),Y(:,ind:ind+N-1),@DISTFUN));
            ind=ind+N;
        end
    end
else
    x=X; y=Y;
%     for i=1:size(X,1)
%         x=[x; X{i,1}];
%     end
%     for i=1:size(Y,1)
%         y=[y; Y{i,1}];
%     end
    J=1;
   for l=1:hirarchialLevels
    w=1/(2^(hirarchialLevels-l));
    for j=J:J+(2^(l-1))-1
        K=K+ w.*exp(-sigma .* pdist2(x(:,j),y(:,j),@DISTFUN2));
        
    end
    J=j+1;
   end 
end