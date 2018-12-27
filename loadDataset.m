function cell=loadDataset(dataset)
global ipDir nActions nSubjects nEpisodes  Njoints natural %L1 L2 L3 L4 L5
% t=load(strcat(dataset,'Natural','.mat'),'natural');
%  natural=t.natural;
%  clear t;
 
% if(reduceJoints)
% IntJoints=[L1 L2 L3 L4 L5];
% Njoints=15;
% end
dataset=['../data/' dataset];
 
 if(exist(strcat(dataset,'.mat'),'file'))
     if(strcmp(dataset,'NTU RGB+D'))
        load (strcat(dataset,'.mat'));
        cell=cells;
     else
          load (strcat(dataset,'.mat'));
     end
%  if(reduceJoints)
%  load (strcat(dataset,'ReducedParts.mat'),'L1','L2','L3','L4','L5');
%  end
        return;
        
 end
 
 
if(strcmp(dataset,'KARD'))
   cell=loadKARDJoints(ipDir, 'screen');
end


for a=1:nActions
  %  if (ismember(a,AS{ASind}))
  index_samples = 1;
    for s=1:nSubjects
        for e=1:nEpisodes
            
            if(strcmp(dataset,'KARD'))
                inputFile= strcat('a',transform(a,2),'_s',transform(s,2),'_e',transform(e,2),'_screen.txt');
            elseif(strcmp(dataset,'NTU RGB+D'))
                 inputFile= strcat('S001C001','P',transform(s,3),'R',transform(e,3),'A',transform(a,3),'.skeleton');
                
            else
                inputFile= strcat('a',transform(a,2),'_s',transform(s,2),'_e',transform(e,2),'_skeleton.txt');
            end
        
        fileName=[ipDir inputFile];
        if(exist(fileName,'file'))
           %%
            if (strcmp(dataset,'UTKinect-Action3D'))
               fp=fopen(fileName);
             % fp=fopen(file);
               if (fp>0)
               B=fscanf(fp,'%f');
               fclose(fp);
               end
               
                l=size(B,1)/4;
                B=reshape(B,4,l);
                B=B';
                B=reshape(B,20,l/20,4);

                X=B(:,:,1);
           
                Z=B(:,:,2);
                
                %Z=B(:,:,2);
                Y=B(:,:,3)/4;
                %Y=B(:,:,3);
               
                t(:,:,1)=X; t(:,:,2)=Y; t(:,:,3)=Z; 
                 cell{a,index_samples}=t;
                clear t
           
            
            elseif(strcmp(dataset,'CAD60'))
               [ X,Y,Z,~ ] = readCAD60files( fileName );
               t(:,:,1)=X; t(:,:,2)=Z; t(:,:,3)=Y; 
                 cell{a,index_samples}=t;
                 clear t
            elseif(strcmp(dataset,'KARD'))
                t=cell{a,index_samples};
                Y=t(:,:,2); Z=t(:,:,3); 
                t(:,:,2)=Z; t(:,:,3)=Y; 
                 cell{a,index_samples}=t;
                 clear t
                 
            elseif(strcmp(dataset,'NTU RGB+D'))     
                bodyinfo = read_skeleton_file(fileName);
                for i=1:size(bodyinfo,2)
                   if(size(bodyinfo(i).bodies,2)==1)
                    for j=1:Njoints
                    X(j,i)=bodyinfo(i).bodies.joints(j).x;
                    Y(j,i)=bodyinfo(i).bodies.joints(j).y;
                    Z(j,i)=bodyinfo(i).bodies.joints(j).z;
                    end
                   end
                end
                t(:,:,1)=X; t(:,:,2)=Z; t(:,:,3)=Y; 
                 cell{a,index_samples}=t;
                 clear t
            end
        end
        index_samples = index_samples+1;
        end
     end
 %end
end
    %end



save(strcat(dataset,'.mat'),'cell');
%save(strcat(dataset,'ReducedParts.mat'),'L1','L2','L3','L4','L5');