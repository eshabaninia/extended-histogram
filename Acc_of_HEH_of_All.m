function [acc,C]=Acc_of_HEH_of_All(Xtrain,XtrainO,Ytrain,RLindtrain,Xtest, XtestO,Ygroundtruth,RLindtest,opt)
%global AS ASind blackList %setup ratio
%as=setdiff(AS{ASind},blackList);
as=opt.as;

%DataX1=[];
DataX1O=[];
DataY1=[];
DataRLind=[];
for i=1:size(as,2)
       % DataX1=[DataX1; Xtrain(Ytrain(:)==as(i),:)];
        DataX1O=[DataX1O; XtrainO(Ytrain(:)==as(i),:)];
        DataY1=[DataY1; Ytrain(Ytrain(:)==as(i))];
        DataRLind=[DataRLind; RLindtrain(Ytrain(:)==as(i))];
end
% 
% randInx=randperm(size(DataX1,1));
% DataX1=DataX1(randInx,:);
% DataY1=DataY1(randInx,:);

% 

%% generating test data
 %if(strcmp(setup,'cross-subject'))
    
    %trainData=DataX1;
    trainDataO=DataX1O;
    trainLabels=DataY1;
    trainRLind=DataRLind;
   % testData=[];
    testDataO=[];
    testLabels=[];
    testRLind=[];

    for i=1:size(as,2)
   % testData=[testData; Xtest(Ygroundtruth(:)==as(i),:)];
    testDataO=[testDataO; XtestO(Ygroundtruth(:)==as(i),:)];
    testLabels=[testLabels; Ygroundtruth(Ygroundtruth(:)==as(i))];
    testRLind=[testRLind; RLindtest(Ygroundtruth(:)==as(i))];
    end

    
% else
%     SIZ=size(DataX1,1);
%     trainData=DataX1(1:SIZ*ratio ,:);
%     trainDataO=DataX1O(1:SIZ*ratio ,:);
%     trainLabels=DataY1(1:SIZ*ratio ,:);
%     trainRLind=DataRLind(1:SIZ*ratio ,:);
%     testData=DataX1((SIZ*ratio)+1:end ,:);
%     testDataO=DataX1O((SIZ*ratio)+1:end ,:);
%     testLabels=DataY1((SIZ*ratio)+1:end ,:);
%     testRLind=DataRLind((SIZ*ratio)+1:end ,:);
%end

% 
% [RANKED,WEIGHT]=relieff(trainData,trainLabels,10);
% SIZ=min(ceil(size(trainData,1)/3),size(trainData,2));
% trainData =  trainData(:,RANKED(1:SIZ));
% testData  =  testData (:,RANKED(1:SIZ));

%% dimension reduction
dimensionReduction=0;
if (dimensionReduction==1)
% 
% % LDA    
%    options = [];
%    options.Fisherface = 1;
%    options.Regu=1;
%    [eigvector, eigvalue] = LDA(trainLabels, options,  trainData);
%     trainData =  trainData*eigvector(:,:);
%    testData = testData*eigvector(:,:);


% PCA
%  eigvector = pca(trainData);
%   ndimensions=min(ceil(size(trainData,2)*3/4),size(eigvector,2));
%   trainData = trainData*eigvector(:,1:ndimensions);
%   testData = testData*eigvector(:,1:ndimensions);

end




% 
% mdl=fitcknn(trainDataO,trainLabels,'NSMethod','exhaustive','Distance',@DISTFUN2);
% labels=predict(mdl,testData);
% C=confusionmat(testLabels,labels);
% acc=100*trace(C)/sum(sum(C));

[accR,CR]=SVMclassify(as,[],trainDataO(trainRLind==1,:),trainLabels(trainRLind==1,:),...
             [],testDataO(testRLind==1,:),testLabels(testRLind==1,:),opt);

          
[accL,CL]=SVMclassify(as,[],trainDataO(trainRLind==0,:),trainLabels(trainRLind==0,:),...
              [],testDataO(testRLind==0,:),testLabels(testRLind==0,:),opt);
 
 if(isempty(CR))
     C=CL; acc=accL;
 elseif(isempty(CL))
     C=CR; acc=accR;
 else
 C=CR+CL;  acc=sum(trace(C))/sum(sum(C));
 end