function Y=mynorm(X,type)
if(type==2)
for i=1:size(X,1)
    Y(i)=sqrt(X(i,1)*X(i,1)+X(i,2)*X(i,2)+X(i,3)*X(i,3));
end

else
for i=1:size(X,1)
    Y(i)=abs(X(i,1))+abs(X(i,2))+abs(X(i,3));
end
    
end
