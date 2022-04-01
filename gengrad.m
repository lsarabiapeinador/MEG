function Y=gengrad(t,nt,nc,tmax)

t=t+1;
k=t-1;

% Initializes generator based on the current time,
% resulting in a different sequence of random numbers after each call.
rng('shuffle');
s = rng;

X=randi(t,nc,nt)-1;
Y=round((X./(sum(X')'))*tmax);
for i=1:nc
    for j=1:nt
        if Y(i,j)>k
            Y(i,j)=k;
        end
    end
end

% ajustar a tmax la suma


for i=1:nc
    YY=Y(i,:);
    SS=sum(YY);
    
    if SS < tmax 
        % recalcular Y(i,:)
        Y(i,:)=menor(YY,tmax,k);
    elseif SS > tmax
        % recalcular Y(i,:)
        Y(i,:)=mayor(YY,tmax,k);
    end
end

end


% calcular cuando SS<tmax

function nY=menor(YY,tmax,k)
cn=tmax-sum(YY);
while cn>0
    Z=find(YY<k);
    ZZ=randi(length(Z),1);
    nY=YY;
    cy=YY(Z(ZZ));
    if cy+cn>k
        ncy=k;
    else
        ncy=cy+cn;
    end
    nY(Z(ZZ))=ncy;
    cn=tmax-sum(nY);
    YY=nY;
end
end



% calcular cuando SS>tmax

function nY=mayor(YY,tmax,k)
cn=sum(YY)-tmax;
while cn>0
    Z=find(YY<k);
    ZZ=randi(length(Z),1);
    nY=YY;
    cy=YY(Z(ZZ));
    if cy-cn<0
        ncy=0;
    else
        ncy=cy-cn;
    end
    nY(Z(ZZ))=ncy;
    cn=sum(nY)-tmax;
    YY=nY;
end
end
