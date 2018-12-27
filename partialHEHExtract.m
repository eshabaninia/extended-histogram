function partialHEHExtract (a,nSubiects,c ,c2, nEpisodes, RightHandedSubjects,hirarchialLevels ,TYPE, eigvectorL ,eigvectorR)

HEH=cell(1,nSubiects*nEpisodes);
HEH2=cell(1,nSubiects*nEpisodes);
for s=1:nSubiects
        for epi=1:nEpisodes
            
            
              [e,e2, o1,o2]=ParrallelhirarchialExtendedHist(c ,c2, nEpisodes, RightHandedSubjects,s,epi,hirarchialLevels ,TYPE, eigvectorL ,eigvectorR);
              if (e==0 && e2==0)
                   HEH{(s-1)*nEpisodes+epi}=o1;
                   HEH2{(s-1)*nEpisodes+epi}=o2;
              end
               %output1=o1; output2=o2;
        end
end
 
  save(['HEH' num2str(a) '.mat'],'HEH','HEH2');