function output=interpolate2(input,itrNum)
%input and output are matrixes of Njoints*Nframes*3 for a seqence of human poses 

[d1,d2,d3]=size(input);

for i=1:d1
    for j=1:d3
        temp=input(i,:,j);
        for k=1:itrNum
            temp=interpn(temp,'cubic');
        end
        output(i,:,j)=temp;
    end
end