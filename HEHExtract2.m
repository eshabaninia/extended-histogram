%% extraction of extended histograms
function HEHExtract2(c,c2)
global nActions nSubjects nEpisodes TYPE hirarchialLevels RightHandedSubjects eigvectorL eigvectorR...
        W AS ASind %HEH HEH2%blackList 
%as=setdiff(AS{ASind},blackList);

%h = waitbar(0,['HEH extraction of all input actions(hirarchialLevels=', num2str(hirarchialLevels),'  TYPE=' TYPE, ' ) Please wait...']);
%ind=0;

nAct=nActions;  set=AS{ASind};nSub=nSubjects; nEpi=nEpisodes; Weight=W;
 RHS=RightHandedSubjects; hl=hirarchialLevels; T=TYPE; eL=eigvectorL; eR=eigvectorR;
N=nSubjects*nEpisodes;
 %LHEH=cell(nAct,N);
 %LHEH2=cell(nAct,N);
parfor a=1:nAct
   warning ('off','all');
     %waitbar(a/nAct);
  if (ismember(a,set))
    %ind=ind+1;
    %w=W(ind,:);
               partialHEHExtract (a,nSub,c(a,:) ,c2(a,:), nEpi, RHS, hl,T, eL ,eR);
               % both HEH of normalized poses and HEH of their mirrors are added as a sample 
%                   LHEH(a,:) =O1;
%                   LHEH2(a,:)=O2;
       
            
  end
end
 
%close(h); 
 %HEH= LHEH;  HEH2= LHEH2;