%% code for extended histogram for human action recognition
% note: svmtrain and svmpredict are renamed to libsvmtrain and libsvmpredict to handle the name conflict between svmtrain in the libsvm and that in MATLAB
function HumanActionRecognition
clc;
close all;
clear all;
warning off;

global dataset  nActions actionSetLabels blackList nSubjects nEpisodes NquassianCompo reduceJoints poseNormalizationFlag  AS ASind ...
       ratio TYPE hirarchialLevels eigvectorL eigvectorR MirrorActions interpolatePoses extracFeaturesOfMirroredActions setup  TrainSubjects  TestSubjects cell cell2

dataset         ='KARD';%  'CAD60'  'UTKinect-Action3D'  'KARD'
NquassianCompo  =1;             % NquassianCompo=0 means multinomial distribution
hirarchialLevels=3;

TYPE='hist3D';                 % 'regular','hist3D'

  % setup determines the type of setup which can be one of the following
  % 'simple'=subjects specified in TrainSubjects for train and in
  % TestSubjects for test. determine trainSubjects and TestSubjects in
  % conf.this is used in cross-subject.
  % 'cross-subject =in each iteration half of the subjects are choosed for train and rest test. the nuber of iterations is equal to the nSubjects/2 choose of nSubjects'
  % 'lOPOCV'=leave one person out cross validation=new person
  % 'same-person'=have-seen=a ratio of data of each person for train and rest
  % for test. determine ratio in conf.
  % 'LOSOCV'=leave one sequence out cross validation
  % there are some recomendations of setup for each dataset in conf
  % function. note that setup is performed on subset of actions specified
  % in conf.
setup='LOPOCV';
precision = @(confusionMat) diag(confusionMat)./sum(confusionMat,2);
recall = @(confusionMat) diag(confusionMat)./sum(confusionMat,1)';
f1Scores = @(confusionMat) 2*(precision(confusionMat).*recall(confusionMat))./(precision(confusionMat)+recall(confusionMat));
meanF1 = @(confusionMat) mean(f1Scores(confusionMat));


configure(dataset);                    % configuring inital values related to the dataset
msg=['dataset=',dataset ,' setup=', setup , ' Action_Set=', num2str(AS{ASind})];
disp(msg);
disp('load dataset...');
cell=loadDataset(dataset);


disp('preprocess (normalizing poses)...');
if(poseNormalizationFlag)
    NormalizingPoses2(1,1);
end

disp('preprocess (mirroring & interpolating if necessary)...');
cell2=Mirr_Interpol(1,nActions,1,nSubjects,1,nEpisodes,MirrorActions,interpolatePoses);

disp('computing eigen vectors...');
    [eigvectorL, eigvectorR]=histComEig();
     eigvectorL=eigvectorL(:,1:min(size(eigvectorL,2),10));
     eigvectorR=eigvectorR(:,1:min(size(eigvectorR,2),10));
for iteration=1:1
disp(('Extracting HEH of all actions...'));
HEHExtract2(cell,cell2);
clear cell cell2
%%

opt.as=setdiff(AS{ASind},blackList);
opt.hirarchialLevels=hirarchialLevels;
if(strcmp(setup,'simple'))
    disp(['cross-subject: persons ', num2str(TrainSubjects), ' for train and persons ', num2str(TestSubjects),' for test' ]);
    
    disp(['feature extraction (NquassianCompo=',num2str(NquassianCompo),', hirarchialLevels=', num2str(hirarchialLevels),'  TYPE=' TYPE, ' ) Please wait...']);
   [Ytrain,XtrainO,RLindtrain,~,Ygroundtruth,XtestO, RLindtest,~]=featureExtract2;

     [acc,C]=Acc_of_HEH_of_All([],XtrainO,Ytrain,RLindtrain,[], XtestO,Ygroundtruth,RLindtest,opt);

    imagesc(C);
    set(gca,'XTick',1:nActions,'XTickLabel',actionSetLabels,'YTick',1:nActions,'YTickLabel',actionSetLabels,'TickLength',[0 0]);
    rotateXLabels( gca(), 20 );
    
    
elseif (strcmp(setup,'cross-subject'))
    states=nchoosek((1:nSubjects),nSubjects/2);
    for i=1:size(states,1)
        TrainSubjects=states(i,:); TestSubjects=setdiff((1:nSubjects),TrainSubjects);
        disp(['cross-subject: persons ', num2str(TrainSubjects), ' for train and persons ', num2str(TestSubjects),' for test' ]);
 
        disp(['feature extraction (NquassianCompo=',num2str(NquassianCompo),', hirarchialLevels=', num2str(hirarchialLevels),'  TYPE=' TYPE, ' ) Please wait...']);
        %featureExtract(1./W,dataset,blackList,ipDir,nActions,nSubjects,nEpisode,TYPE,Njoints,NquassianCompo,hirarchialLevels);
        [Ytrain,XtrainO,RLindtrain,~,Ygroundtruth,XtestO, RLindtest,~]=featureExtract2;
    [acc(i,:),C]=Acc_of_HEH_of_All([],XtrainO,Ytrain,RLindtrain,[], XtestO,Ygroundtruth,RLindtest,opt);
    %disp(['accuracy=', num2str(acc(1))]);
    
    imagesc(C);
    set(gca,'XTick',1:nActions,'XTickLabel',actionSetLabels,'YTick',1:nActions,'YTickLabel',actionSetLabels,'TickLength',[0 0]);
   % rotateXLabels( gca(), 20 );
    end
elseif(strcmp(setup,'LOPOCV'))
    for i=1:nSubjects
        TrainSubjects=setdiff([1:nSubjects],i);
        TestSubjects=i;
        disp(['leave person ', num2str(i), ' out cross validation' ]);
        disp(['feature extraction (NquassianCompo=',num2str(NquassianCompo),', hirarchialLevels=', num2str(hirarchialLevels),'  TYPE=' TYPE, ' ) Please wait...']);
  
        [Ytrain,XtrainO,RLindtrain,~,Ygroundtruth,XtestO, RLindtest,~]=featureExtract2;
        [acc(i,:),C]=Acc_of_HEH_of_All([],XtrainO,Ytrain,RLindtrain,[], XtestO,Ygroundtruth,RLindtest,opt);
        if(i==1 )
            confmat=C;
        elseif(~isempty(C))
            confmat=confmat + C;
        end
    end
    
    confmat=confmat/nSubjects;
    
    for i=1:size(confmat,2)
        confmat(i,:)=(confmat(i,:)./sum(confmat(i,:)))*100;
    end
   
    disp(['mean accuracy=', num2str(100*trace(confmat)/sum(sum(confmat)))]);
    accuracay(iteration)=100*trace(confmat)/sum(sum(confmat));
    recal(iteration)=mean(recall(confmat));
    prec(iteration)=mean(precision(confmat));
    imagesc(confmat);
    confusionmat(:,:,iteration)=confmat;
    title(msg);
    set(gca,'XTick',1:nActions,'XTickLabel',actionSetLabels,'YTick',1:nActions,'YTickLabel',actionSetLabels,'TickLength',[0 0]);
%    rotateXLabels( gca(), -20 );

elseif(strcmp(setup,'LOSOCV'))
    TrainSubjects=AS{ASind};
    TestSubjects=[];
    [Y,XO,RLind,~,~,~,~, ~]=featureExtract2;
   
    if(MirrorActions)
        stepsz=2;
    else
        stepsz=1;
    end
    
    parfor i=1:size(XO,1)
        if(mod(i,stepsz)==1)
        disp(['leave sequence ', num2str(i), ' out of ', num2str(size(XO,1)), ' sequences' ]);
       % Xtrain=[X(1:i-1,:); X(i+1:end,:)];
        XtrainO=[XO(1:i-1,:); XO(i+1:end,:)];
        Ytrain=[Y(1:i-1,:); Y(i+1:end,:)];
        RLindtrain=[RLind(1:i-1,:); RLind(i+1:end,:)];
        
        %Xtest       =X(i,:);
        Ygroundtruth=Y(i,:);
        XtestO      =XO(i,:);
        RLindtest=RLind(i,:);
        [acc(i,:),C]=Acc_of_HEH_of_All([],XtrainO,Ytrain,RLindtrain,[], XtestO,Ygroundtruth,RLindtest,opt);
        %if(i==1)
            confmat(:,:,i)=C;
        %else
         %   confmat=confmat + C;
        %end
        end  
    end
    acc2=acc(1:stepsz:size(XO,1),1);
    disp(['mean accuracy=', num2str(mean(acc2))]);
    
    confmat=sum(confmat,3)/size(acc2,1);
    imagesc(confmat);
    set(gca,'XTick',1:nActions,'XTickLabel',actionSetLabels,'YTick',1:nActions,'YTickLabel',actionSetLabels,'TickLength',[0 0]);
    rotateXLabels( gca(), 20 );


elseif(strcmp(setup,'same-person'))

    
        disp(['feature extraction (NquassianCompo=',num2str(NquassianCompo),', hirarchialLevels=', num2str(hirarchialLevels),'  TYPE=' TYPE, ' ) Please wait...']);
       TrainSubjects= AS{ASind};
       TestSubjects=[];
      [Y,XO,RLind,Subjects,~,~, ~,~]=featureExtract2;
    
   
    h = waitbar(0,'classification : ');
    for i=1:10
        XtrainO=[];Ytrain=[];RLindtrain=[];
        Ygroundtruth=[];XtestO=[];RLindtest=[];
        waitbar(i/10,h,['classificaton : round ', num2str(i), ' of 10' ]);
        for s=1:nSubjects
            
            SIZ=sum((Subjects==s));
            randInx=randperm(SIZ);
%             temp=X(Subjects==s,:);
%             temp=temp(randInx,:);
%             Xtrain=[Xtrain; temp(1:SIZ*ratio,:)];
%             Xtest =[Xtest;  temp(1+SIZ*ratio:end,:)];
            
            temp=XO(Subjects==s,:);
            temp=temp(randInx,:);
            XtrainO=[XtrainO; temp(1:SIZ*ratio,:)];
            XtestO =[XtestO;  temp(1+SIZ*ratio:end,:)];
            
            temp=Y(Subjects==s,:);
            temp=temp(randInx,:);
            Ytrain=[Ytrain; temp(1:SIZ*ratio,:)];
            Ygroundtruth =[Ygroundtruth;  temp(1+SIZ*ratio:end,:)];
            
            temp=RLind(Subjects==s,:);
            temp=temp(randInx,:);
            RLindtrain=[RLindtrain; temp(1:SIZ*ratio,:)];
            RLindtest =[RLindtest;  temp(1+SIZ*ratio:end,:)];
            
%             
%             Xtrain=[Xtrain; X(randInx(1:SIZ*ratio),:)];
%             XtrainO=[XtrainO; XO(randInx(1:SIZ*ratio),:)];
%             Ytrain=[Ytrain; Y(randInx(1:SIZ*ratio))];
%             RLindtrain=[RLindtrain; RLind(randInx(1:SIZ*ratio),:)];
%             
%             Xtest=[Xtest; X(randInx((SIZ*ratio)+1:end),:)];
%             Ygroundtruth=[Ygroundtruth; Y(randInx((SIZ*ratio)+1:end))];
%             XtestO=[XtestO; XO(randInx((SIZ*ratio)+1:end),:)];
%             RLindtest=[RLindtest; RLind(randInx((SIZ*ratio)+1:end),:)];
        end
        [acc(i,:),C]=Acc_of_HEH_of_All([],XtrainO,Ytrain,RLindtrain,[], XtestO,Ygroundtruth,RLindtest,opt);
        if(i==1)
            confmat=C;
        else
            confmat=confmat + C;
        end
    end
    close(h);
    
    confmat=confmat/10;
    
    for i=1:size(confmat,2)
        confmat(i,:)=(confmat(i,:)./sum(confmat(i,:)))*100;
    end
   
    disp(['mean accuracy=', num2str(100*trace(confmat)/sum(sum(confmat)))]);
    
    imagesc(confmat);
    title(msg);
    set(gca,'XTick',1:size(AS{ASind},2),'XTickLabel',actionSetLabels,'YTick',1:size(AS{ASind},2),'YTickLabel',actionSetLabels,'TickLength',[0 0]);
    rotateXLabels( gca(), 20 );
    
end
end
warning on;