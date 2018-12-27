function [e1,e2, output1,output2] =ParrallelhirarchialExtendedHist(cell ,cell2, nEpisodes, RightHandedSubjects,s,epi,hirarchialLevels ,TYPE, eigvectorL ,eigvectorR)

 t1 =cell {1,(s-1)*nEpisodes+epi};
 t2 =cell2{1,(s-1)*nEpisodes+epi};
if(isempty(t1))
    e1=1; 
    e2=1;
    output1={};output2={};
    return;
end
% input1=[]; input2=[];
% for j=1:size(t1,2)
%     S1 =[ t1(:,j,1) t1(:,j,2) t1(:,j,3)];
%     S2 =[ t2(:,j,1) t2(:,j,2) t2(:,j,3)];
%     input1=[input1; S1];
%     input2=[input2; S2];
% end

if (ismember(s, RightHandedSubjects))
[e1,output1]=ParalelHEH4(t1,1,hirarchialLevels, TYPE ,eigvectorL, eigvectorR);
    if(e1==1)
        e2=1; output2={};
    else
      [ e2,output2]=ParalelHEH4(t2,2,hirarchialLevels, TYPE ,eigvectorL, eigvectorR);
    end
    
else
[e1,output1]=ParalelHEH4(t1,2,hirarchialLevels, TYPE ,eigvectorL, eigvectorR);
    if(e1==1)
        e2=1; output2={};
    else
      [ e2,output2]=ParalelHEH4(t2,1,hirarchialLevels, TYPE ,eigvectorL, eigvectorR);
    end

end
