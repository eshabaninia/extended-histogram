function b=transform(a,digitnum)
b=int2str(a);
if(size(b,2)>digitnum)
    b='error';
    return;
end

while(size(b,2)~=digitnum)
    b=['0' b];
end

