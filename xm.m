function c=xm(x)

c=[-1, -1, -1];
P=[0.5 0.866025 ; 1 0];
co=x*inv(P);
c(1)=co(1);
c(3)=co(2);
c(2)=1-c(1)-c(3);
end