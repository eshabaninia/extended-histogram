%% extraction of extended histograms
function  [Ytrain,XtrainO,RLindtrain,Subjectstrain,Ygroundtruth,XtestO, RLindtest,Subjectstest]=featureExtract 
global nActions nSubjects nEpisodes TYPE hirarchialLevels MirrorActions ...
       TrainSubjects TestSubjects  RightHandedSubjects W AS ASind blackList %HEH HEH2
as=setdiff(AS{ASind},blackList);
Subjects=[]; XO=[]; RLind=[]; firstSubjects=[]; secondSubjects=[]; firstHulfRLind=[]; secondHulfRLind=[];
 firstHulfXO=[]; firstHulfY=[]; secondHulfXO=[];secondHulfY=[];
h = waitbar(0,['feature extraction ( hirarchialLevels=', num2str(hirarchialLevels),'  TYPE=' TYPE, ' ) Please wait...']);
ind=0;

for a=1:nActions
    load(['HEH' num2str(a) '.mat'],'HEH','HEH2');
  if (ismember(a,AS{ASind}))
    ind=ind+1;
    %w=W(ind,:);
    for s=1:nSubjects
        for epi=1:nEpisodes
            
            if(sum(ismember(TrainSubjects,s)==1))
                weight=W;
            else
                weight=W;
%                   weight(:,L2(1,:),:)=0;
%                    weight(:,L2(2,end),:)=0;
%                 weight(:,L3(1,:),:)=0;
%                 weight(:,L3(2,end),:)=0;
            end
            
              output1=HEH{1,(s-1)*nEpisodes+epi};
               output2=HEH2{1,(s-1)*nEpisodes+epi};
            
              if(isempty(output1)==0 && isempty(output2)==0)
               % both HEH of normalized poses and HEH of their mirrors are added as a sample 
      
               %token=zeros(1,size(as,2));
               %token(find(as==a))=1;
               Subjects=[Subjects,s];
               RLind=[RLind; ismember(s, RightHandedSubjects)];
                          
               if(size(XO)==0)
                 XO=output1;
                 Y=a;
               else
                 XO=[XO; output1];
                 Y=[Y; a ];
               end
               if(MirrorActions)
                 XO=[XO; output2];      
                 RLind=[RLind; ~ismember(s, RightHandedSubjects)];
                 %Y=[Y; a ];
                 Y=[Y; a ];
                 Subjects=[Subjects,s];
               end
             
             if(sum(ismember(TrainSubjects,s)==1))
             %if(s<=(nSubjects/2))
              
              firstHulfY= [firstHulfY; a];
              firstHulfRLind=[firstHulfRLind; ismember(s, RightHandedSubjects)];
              firstSubjects=[firstSubjects; s];
              if(size(firstHulfXO)==0)
                 firstHulfXO=output1;
              else
                 firstHulfXO=[firstHulfXO; output1];
              end
              
              if(MirrorActions)
              firstHulfXO=[firstHulfXO; output2];
              firstHulfY= [firstHulfY; a];
              firstHulfRLind=[firstHulfRLind; ~ismember(s, RightHandedSubjects)];
              firstSubjects=[firstSubjects; s];
              end
              
             elseif(sum(ismember(TestSubjects,s)==1))
                 
                 secondHulfY= [secondHulfY; a ];
                 secondHulfRLind=[secondHulfRLind; ismember(s, RightHandedSubjects)];
                 secondSubjects=[secondSubjects; s];
              if(size(secondHulfXO)==0)
                 secondHulfXO=output1;
              else
                 secondHulfXO=[secondHulfXO; output1];
              end
             end
             
              else
                   hhhhhhhhh=0;
               end
            
        end
    end
  end
  waitbar(a/nActions);
end
close(h); 


 Ytrain=firstHulfY;XtrainO=firstHulfXO;RLindtrain=firstHulfRLind;
        Ygroundtruth=secondHulfY;  XtestO=secondHulfXO;  RLindtest=secondHulfRLind;
Subjectstrain=firstSubjects ; Subjectstest=secondSubjects;