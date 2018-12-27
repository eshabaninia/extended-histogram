function N=normalizeHeight2(S,L1, L2, L3, L4, L5, hipCenter)
% S=S(:,1:3);
% L1=[ 20    3     4;   
%      3     4     7];  
% L2=[ 7     5     14    16;
%      5    14     16    18];
% L3=[ 7     6     15    17;
%      6    15     17    19];
% L4=[ 3     1     8    10;
%      1     8     10   12];
% L5=[ 3     2     9    11;
%      2     9     11   13];
height=lenght(L1, S)+ max(lenght(L2,S),lenght(L3,S));
handsLenght=lenght(L4,S)+lenght(L5,S);


N(hipCenter,:)=S(hipCenter,:);
for i=size(L1,2):-1:1
    p=L1(1,i);
    q=L1(2,i);
    N(p,:)=N(q,:)+((S(p,:)-S(q,:))/height);
end

% N(4,:)=N(7,:)+(S(4,:)-S(7,:))*norm(S(4,:)-S(7,:))/height;
% N(3,:)=N(4,:)+(S(3,:)-S(4,:))*norm(S(3,:)-S(4,:))/height;
% N(20,:)=N(3,:)+(S(20,:)-S(3,:))*norm(S(20,:)-S(3,:))/height;

for i=1:size(L2,2)
    p=L2(2,i);
    q=L2(1,i);
    N(p,:)=N(q,:)+((S(p,:)-S(q,:))/height);
end


% N(5,:)=N(7,:)+(S(5,:)-S(7,:))*norm(S(5,:)-S(7,:))/height;
% N(14,:)=N(5,:)+(S(14,:)-S(5,:))*norm(S(14,:)-S(5,:))/height;
% N(16,:)=N(14,:)+(S(16,:)-S(14,:))*norm(S(16,:)-S(14,:))/height;
% N(18,:)=N(16,:)+(S(18,:)-S(16,:))*norm(S(18,:)-S(16,:))/height;


for i=1:size(L3,2)
    p=L3(2,i);
    q=L3(1,i);
    N(p,:)=N(q,:)+((S(p,:)-S(q,:))/height);
end

% N(6,:)=N(7,:)+(S(6,:)-S(7,:))*norm(S(6,:)-S(7,:))/height;
% N(15,:)=N(6,:)+(S(15,:)-S(6,:))*norm(S(15,:)-S(6,:))/height;
% N(17,:)=N(15,:)+(S(17,:)-S(15,:))*norm(S(17,:)-S(15,:))/height;
% N(19,:)=N(17,:)+(S(19,:)-S(17,:))*norm(S(19,:)-S(17,:))/height;

ratio=handsLenght/height;

for i=1:size(L4,2)
    p=L4(2,i);
    q=L4(1,i);
    N(p,:)=N(q,:)+((S(p,:)-S(q,:))/handsLenght);
end

for i=1:size(L5,2)
    p=L5(2,i);
    q=L5(1,i);
    N(p,:)=N(q,:)+((S(p,:)-S(q,:))/handsLenght);
end
% N(1,:)=N(3,:)+(S(1,:)-S(3,:))*norm(S(1,:)-S(3,:))/handsLenght;
% N(2,:)=N(3,:)+(S(2,:)-S(3,:))*norm(S(2,:)-S(3,:))/handsLenght;
% N(9,:)=N(2,:)+(S(9,:)-S(2,:))*norm(S(9,:)-S(2,:))/handsLenght;
% N(11,:)=N(9,:)+(S(11,:)-S(9,:))*norm(S(11,:)-S(9,:))/handsLenght;
% N(13,:)=N(11,:)+(S(13,:)-S(11,:))*norm(S(13,:)-S(11,:))/handsLenght;
% N(8,:)=N(1,:)+(S(8,:)-S(1,:))*norm(S(8,:)-S(1,:))/handsLenght;
% N(10,:)=N(8,:)+(S(10,:)-S(8,:))*norm(S(10,:)-S(8,:))/handsLenght;
% N(12,:)=N(10,:)+(S(12,:)-S(10,:))*norm(S(12,:)-S(10,:))/handsLenght;

lenght([L1 L2],N);
lenght([L1 L3],N);
lenght([L4 L5],N);
% t=[L1 L2 L3 L4 L5]; average=[];
% for i=1:size(t,2)
%     average=[average; lenght([t(1,i); t(2,i)],N)];
% end
% average