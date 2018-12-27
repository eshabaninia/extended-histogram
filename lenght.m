function l=lenght(path, S)
l=0;
for j=1:size(path,2)
        c1=path(1,j);
        c2=path(2,j);
        l=l+ norm([S(c1,1)-S(c2,1), S(c1,2)-S(c2,2), S(c1,3)-S(c2,3)]);
end
    
