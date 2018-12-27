function K=PYRKernel2(pd,type,sigma,hirarchialLevels)


K=zeros(size(squareform( reshape(pd(1,1,:),1,[]))));
if(type==1)
    N=size(X,2)/(2^(hirarchialLevels)-1);
    ind=1;
    for l=1:hirarchialLevels
        w=1/(2^(hirarchialLevels-l));
        for j=1:2^(l-1)
            K=K+ w.*exp(-sigma .*squareform( pd(l,j,:)));
            ind=ind+N;
        end
    end
 else
%     x=[]; 
%     for i=1:size(X,1)
%         x=[x; X{i,1}];
%     end
%     
    J=1;
   for l=1:hirarchialLevels
    w=1/(2^(hirarchialLevels-l));
    for j=J:J+(2^(l-1))-1
        K=K+ w.*exp(-sigma .* squareform(reshape(pd(l,j,:),1,[])));
        
    end
    J=j+1;
   end 
end