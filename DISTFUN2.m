function D2 = DISTFUN2(ZI,ZJ)
% ZI,ZJ represent vectors of gmm distributions.
D2(1:size(ZJ,1))=0;

mean1=(ZI{1,1}.mu)';
 Var1=ZI{1,1}.Sigma;
% [s1, s2, s3]=size(Var1);
% Var1=reshape(Var1,s2,s1,s3);
p1=ZI{1,1}.PComponents;

    for j=1:size(ZJ,1)  
        
            mean2=(ZJ{j,1}.mu)';
             Var2=ZJ{j,1}.Sigma;
%             [s1, s2, s3]=size(Var2);
%             Var2=reshape(Var2,s2,s1,s3);
            p2=ZJ{j,1}.PComponents;
            
            %MOGSymmetrized_divergence computation
            temp=MOGSymmetrized_divergence(mean1,Var1,p1,mean2,Var2,p2);
            D2(j)=D2(j)+temp;
       
    end
    
D2=D2';