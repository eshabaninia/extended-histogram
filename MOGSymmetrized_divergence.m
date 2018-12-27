function d=MOGSymmetrized_divergence(mean1,var1,p1,mean2,var2,p2)
d1=0;
for i=1:size(mean1,2)
    s1=0;
    for j=1:size(mean1,2)
        if(size(var1,1)==1)
           V1=diag(var1(:,:,i));
           V2=diag(var1(:,:,j));
        else
            V1=var1(:,:,i);
            V2=var1(:,:,j);
        end
        
      
        s1=s1+p1(j)*exp(-NormalKL(mean1(:,i),V1,mean1(:,j),V2));
    end
    
    s2=0;
    for j=1:size(mean2,2)
       if(size(var1,1)==1)
        V1=diag(var1(:,:,i));
       else
        V1=var1(:,:,i);
       end
       
       if(size(var2,1)==1)
        V2=diag(var2(:,:,j));
       else
        V2=var2(:,:,j);
       end
       
        s2=s2+p2(j)*exp(-NormalKL(mean1(:,i),V1,mean2(:,j),V2));
    end
d1=d1+ p1(i)*log(s1/s2);
end


d2=0;
for i=1:size(mean2,2)
    s1=0;
    for j=1:size(mean2,2)
      if(size(var2,1)==1) 
        V1=diag(var2(:,:,i));
        V2=diag(var2(:,:,j));
      else
        V1=var2(:,:,i);
        V2=var2(:,:,j);
      end
        
        s1=s1+p2(j)*exp(-NormalKL(mean2(:,i),V1,mean2(:,j),V2));
    end
    
    s2=0;
    for j=1:size(mean1,2)
      if(size(var2,1)==1) 
        V1=diag(var2(:,:,i));
      else
        V1=var2(:,:,i);
      end
      
      if(size(var1,1)==1) 
        V2=diag(var1(:,:,j));
      else
        V2=var1(:,:,j);
      end
        s2=s2+p1(j)*exp(-NormalKL(mean2(:,i),V1,mean1(:,j),V2));
    end
d2=d2+ p2(i)*log(s1/s2);
end

d=d1+d2;