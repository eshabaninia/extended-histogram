function [acc,C]=SVMclassify(as,trainData,trainDataO,trainLabels,testData,testDataO,testLabels,opt)
hirarchialLevels=opt.hirarchialLevels;
C=[]; acc=0;
if(isempty(testLabels))
    return;
end

% libsvmwrite('train',trainLabels, sparse(trainData) );
% libsvmwrite('test' ,testLabels , sparse(testData) );
%  [~,cmdout]=system('svm-scale -l 0 -u 1 -s scaling_parameters train > train.scale');
% % fileID = fopen('train.file','w'); fprintf(fileID,cmdout); fclose(fileID);
%  [~,cmdout]=system('svm-scale -r scaling_parameters test > test.scale');
% % fileID = fopen('test.file','w'); fprintf(fileID,cmdout); fclose(fileID);
% [trainLabels, trainData] = libsvmread('train.scale');
% [testLabels , testData]  = libsvmread('test.scale');


% trainData=zscore(trainData);
% testData=zscore(testData);
% % 
%  trainData= trainData/cov(trainData);
%  testData= testData/(cov(testData));



%# compute kernel matrices between every pairs of (train,train) and
%# (test,train) instances and include sample serial number as first column
% K =  [ (1:size(trainData,1))' , PYRKernel(trainData,trainData,1) ];
% KK = [ (1:size(testData,1))'  , PYRKernel(testData,trainData,1)  ];



 x=[];
  for j=1:size(trainDataO,1)
     t=(trainDataO(j,:));
     x=[x; t];       
     
  end
  
    J=1; 
  for l=1:hirarchialLevels
   for j=J:J+(2^(l-1))-1
        pd(l,j,:)=pdist(x(:,j),@DISTFUN2);    
        %pd2(l,j,:,:)=pdist2(y(:,j),x(:,j),@DISTFUN2);    
   end
   J=j+1;
  end 


sigma=2.^((1:20)-15); 
bestcv=0; %bestKO(1:size(train,1),1:size(train,1)+1)=0;

for f=1:20
   KO = [(1:size(trainDataO,1))' , PYRKernel2(pd,2,sigma(f),hirarchialLevels)];

  for log2c=-1:6
    
    
    cmd=['-v 5 -t 4 -c ', num2str(2^log2c),' -q '];
    
    cv=libsvmtrain(trainLabels, KO, cmd);
    if(cv>bestcv)
    bestcv=cv; bestc=2^log2c; bestf=sigma(f);
    end
    
  end
end

  KO = [(1:size(trainDataO,1))' , PYRKernel2(pd,2,bestf,hirarchialLevels)];
cmd=['-t 4 -c   ', num2str(bestc) ,' -q '];
model=libsvmtrain(trainLabels, KO, cmd);
 libsvmpredict(trainLabels, KO, model);
 KKO = [ (1:size(testDataO,1))'  , PYRKernelTest(testDataO,trainDataO,2,bestf,hirarchialLevels)  ];
 [predClass, acc, decVals]=libsvmpredict(testLabels, KKO, model);
 % plotconfusionmat(testLabels,pl)
%  plotconfusion(testLabels,pl);
%end
%mean(accuracy(1,:))
C = confusionmat(testLabels,predClass,'order',as);