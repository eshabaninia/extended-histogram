function configure(dataset)
global ipDir Njoints nActions actionSetLabels nSubjects nEpisodes blackList ...
      L1 L2 L3 L4 L5 itrNum ...
      AS ASind ratio RightHandedSubjects LeftHandedSubjects TrainSubjects TestSubjects interpolatePoses MirrorActions reduceJoints ...
      head shoulderCenter shoulderLeft shoulderRight Spine hipCenter hipLeft hipRight natural poseNormalizationFlag
   
    
itrNum=1;
poseNormalizationFlag=1;
%%  
if(strcmp(dataset,'KARD'))
    ipDir = 'G:\KARD dataset\KARD skeleton\';
    Njoints=15;
    nActions=18;
    actionLabels={'Horizontal arm wave','High arm wave','Two hand wave','Catch Cap','High throw','Draw X','Draw Tick','Toss Paper','Forward Kick','Side Kick','Take Umbrella','Bend','Hand Clap','Walk','Phone Call','Drink','Sit down','Stand up'};
    nSubjects=10;
    nEpisodes=3;
   %blackList=[7  13 14 20];
    blackList=[];
    
    % some needed joint indices
%     
%     head=1;
%     shoulderCenter=2;
%     shoulderLeft=6;
%     shoulderRight=3;
%     %Spine=
%     hipCenter=9;
%     hipLeft=13;
%     hipRight=10;
%     
%     
    L1=[ 1    2;   
         2    9 ];  
    L2=[ 9     10     11;
         10     11     12];
    L3=[ 9     13    14;
         13    14    15];
    L4=[ 2     3     4;
         3     4     5];
    L5=[ 2     6     7;
         6     7     8];
    reduceJoints=0;
   % train and test may be required for specific subset of actions, this
   % has been spcially done for MSRAction3D dataset alot in the litreture.
   AS{1}=[1 3 12 15 18 9 6 14 ];
   AS{2}=[2 10 4 7 13 9 12 17];
   AS{3}=[7 16 17 15 11 8 5 1];
   AS{4}=(1:18);  
    ASind=4;
    %setup='LOPOCV'; %'cross-subject';
    ratio=1/3;
    
   % list of subjects that perform an action with right or left hand
   RightHandedSubjects=(1:10);
   LeftHandedSubjects=[];
   TrainSubjects=[ 2 3 4 5 6 7 8 9 10];
   TestSubjects=[1];
   interpolatePoses=1;
    itrNum=2;
   MirrorActions=0;
end

%%
if(strcmp(dataset,'UTKinect-Action3D'))
    ipDir = 'F:\myUTKinect-Action3D Dataset\';
    Njoints=20;
    nActions=10;
    actionLabels={};
    nSubjects=10;
    nEpisodes=2;
   %blackList=[7  13 14 20];
    blackList=[];
    
    % some needed joint indices
%     head=4;
%     shoulderCenter=3;
%     shoulderLeft=5;
%     shoulderRight=9;
%     Spine=2;
%     hipCenter=1;
%     hipLeft=13;
%     hipRight=17;
    actionLabels={'walk', 'sit down', 'stand up', 'pick up', 'carry', 'throw', 'push', 'pull', 'wave', 'clap hands'};
    % skeleton is represented by [L1 L2 L3 L4 L5], where Li represents a
    % body part by corresponding indices
    L1=[4    3     2;   
        3    2     1];  
    L2=[1    13     14    15;
        13   14     15    16];
    L3=[1    17     18    19;
        17   18     19    20];
    L4=[3     5     6    7;
        5     6     7    8];
    L5=[3     9     10   11;
        9     10    11   12];
   reduceJoints=0;
   % train and test may be required for specific subset of actions, this
   % has been spcially done for MSRAction3D dataset alot in the litreture.
    AS{1}=(1:10);  
    ASind=1;
    %setup='LOSOCV';
    ratio=1/3;
    
   % list of subjects that perform an action with right or left hand
   RightHandedSubjects=[1 2 3 4 5 6 7 8 10];
   LeftHandedSubjects=[9];
   TrainSubjects=(1:2:10);
   TestSubjects=(2:2:10);
   interpolatePoses=1;
    itrNum=4;
   MirrorActions=1;
 end

 
%%  
  if(strcmp(dataset,'CAD60'))
    ipDir = 'G:\CAD60Skeleton(15joints)\';
    %ipDir='C:\Users\ali\Desktop\test\';
    Njoints= 15;
    nActions=14;
    actionLabels={'still','talking on the phone','writing on whiteboard','drinking water','rinsing mouth with water','brushing teeth','wearing contact lenses','talking on couch','relaxing on couch','cooking (chopping)','cooking (stirring)','opening pill container','working on computer','random'};
    nSubjects=4;
    nEpisodes=3;
    blackList=[];
    
%     head=1;
%     shoulderCenter=2;
%     shoulderLeft=4;
%     shoulderRight=6;
%     %Spine=
%     hipCenter=3;
%     hipLeft=8;
%     hipRight=10;
    
    
    L1=[ 1    2;   
         2    3 ];  
    L2=[ 3     8     9;
         8     9     14];
    L3=[ 3     10    11;
         10    11    15];
    L4=[ 2     4     5;
         4     5     12];
    L5=[ 2     6     7;
         6     7     13];

    reduceJoints=0;
    AS{1}=[6, 5, 7];
    AS{2}=[2,4,12];
    AS{3}=[10,11,4,12];
    AS{4}=[2,4,8,9];
    AS{5}=[2,3,4,13];
    AS{6}=(1:14); 
    ASind=6;
    %setup='LOPOCV'; %'same-person';
    ratio=1;
    
   RightHandedSubjects=[1 2 4];
   LeftHandedSubjects=3;
   TrainSubjects=[ 2 3 4];
   TestSubjects=[1];
   interpolatePoses=0;
   MirrorActions=1;
  end
 
  %%
  if(strcmp(dataset,'NTU RGB+D'))
    ipDir = 'G:\nturgbdSkeletons\skeletons\';
    
    Njoints= 25;
    nActions=60;
    actionLabels={
    'drink water',
    'eat meal/snack',
    'brushing teeth',
    'brushing hair',
    'drop',
    'pickup',
    'throw',
    'sitting down',
    'standing up (from sitting position)',
    'clapping',
    'reading',
    'writing',
    'tear up paper',
    'wear jacket',
    'take off jacket',
    'wear a shoe',
    'take off a shoe',
    'wear on glasses',
    'take off glasses',
    'put on a hat/cap',
    'take off a hat/cap',
    'cheer up',
    'hand waving',
    'kicking something',
    'put something inside pocket / take out something from pocket',
    'hopping (one foot jumping)',
    'jump up',
    'make a phone call/answer phone',
    'playing with phone/tablet',
    'typing on a keyboard',
    'pointing to something with finger',
    'taking a selfie',
    'check time (from watch)',
    'rub two hands together',
    'nod head/bow',
    'shake head',
    'wipe face',
    'salute',
    'put the palms together',
    'cross hands in front (say stop)',
    'sneeze/cough',
    'staggering',
    'falling',
    'touch head (headache)',
    'touch chest (stomachache/heart pain)',
    'touch back (backache)',
    'touch neck (neckache)',
    'nausea or vomiting condition',
    'use a fan (with hand or paper)/feeling warm',
    'punching/slapping other person',
    'kicking other person',
    'pushing other person',
    'pat on back of other person',
    'point finger at the other person',
    'hugging other person',
    'giving something to other person',
    'touch other persons pocket',
    'handshaking',
    'walking towards each other',
    'walking apart from each other',
};
    nSubjects=40;
    nEpisodes=96;
    blackList=[];
    
%     head=4;
%     shoulderCenter=21;
%     shoulderLeft=9;
%     shoulderRight=5;
%     %Spine=
%     hipCenter=1;
%     hipLeft=17;
%     hipRight=13;
    
    
    L1=[ 4    3  21 2;   
         3    21  2 1];  
    L2=[ 1    13  14 15;
         13   14  15 16];
    L3=[ 1    17   18 19;
         17   18   19 20];
    L4=[ 21    5   6 7 8  23;
         5     6   7 8 23 22];
    L5=[ 21    9    10 11 12 25;
         9    10    11 12 25 24];

    
    AS{1}=[];
    AS{2}=[];
    AS{3}=[];
    AS{4}=[];
    AS{5}=[];
    AS{6}=(1:60); 
    ASind=6;
    %setup='LOPOCV'; %'same-person';
    ratio=1;
    
   RightHandedSubjects=[1:40];
   LeftHandedSubjects=[];
   TrainSubjects=[1, 2, 4, 5, 8, 9, 13, 14, 15,16, 17, 18, 19, 25, 27, 28, 31, 34, 35, 38];
   TestSubjects=setdiff([1:40],TrainSubjects);
   interpolatePoses=1;
   itrNum=3;
   MirrorActions=0;
  
  end
%%
 %actionSetLabels={};
 temp=AS{ASind};
for i=1:size(temp,2)
    t=actionLabels(temp(1,i));
    actionSetLabels{i}=t{1,1};
end

head=L1(1,1); shoulderCenter=L1(1,2); shoulderLeft=L4(1,2); shoulderRight=L5(1,2); hipCenter=L1(2,end); hipLeft=L2(1,2); hipRight=L3(1,2);

% t=load(strcat(dataset,'Natural',num2str(Njoints),'.mat'),'natural');
% natural=t.natural;