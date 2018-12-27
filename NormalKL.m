function y=NormalKL(m0,v0,m1,v1)
d=size(m0,1);
if(d==1)
    y=0.5*((v0./v1)+((m1-m0).*(m1-m0).*(1./v1))-1+log(v1/v0));
else
    
inv0 = inv(v0);
inv1 = inv(v1);

y=0.5*(log(det(inv0*v1))+trace(inv1*v0)-d+((m0-m1)'*inv1*(m0-m1)));
end