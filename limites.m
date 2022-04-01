function [C1,C2]=limites(L,alfa)

if (L<0) || (L>200)
    error('Valor de L no válido')
end

if L < 100
    bandera = -1;
elseif L==100
    bandera = 0;
elseif L>100
    bandera =1;
end
    
    
switch bandera
    case -1
    
      if (alfa < 0) || (alfa >120)
          error('Ángulo no válido');
      end
      
      C1=[L/100 1-(L/100) 0];  
      x=mx(C1);
      beta=(180-alfa)*pi/180; % formato algebraico estándar en radianes
      brc=tan(beta); % pendiente de la recta rc
      arc=x(2)-brc*x(1); % tno. indep. de rc
      xr=[-arc/brc  0]; % corte con r2
      if xr(1)>1
          xr(1)=(1.73205-arc)/(1.73205+brc); %abscisa corte con r3
          xr(2)= -1.73205*xr(1)+1.73205; % ordenada corte con r3
      end
     
      C2=xm(xr);
      
      if (L==0) & (alfa==0)
          C2=[0 0 1];
      end
     
      
    case 0 
        if (alfa < 60) || (alfa >120)
          error('Ángulo no válido');
        end 
        C1=[1 0 0];
        x=mx(C1);
        beta=(180-alfa)*pi/180; % formato algebraico estándar en radianes
        brc=tan(beta); % pendiente de la recta rc
        arc=x(2)-brc*x(1); % tno. indep. de rc
        xr=[-arc/brc  0]; % corte con r2
        C2=xm(xr);
        
        
    case 1
        if (alfa < 0) || (alfa >120)
          error('Ángulo no válido');
        end
        C1=[(200-L)/100 0 (L-100)/100];
        x=mx(C1);
        beta=(alfa)*pi/180; % formato algebraico estándar en radianes
        brc=tan(beta); % pendiente de la recta rc
        arc=x(2)-brc*x(1); % tno. indep. de rc
        xr=[-arc/brc  0]; % corte con r2
        if (xr(1)>1) || (xr(1)<0)
          xr(1)=arc/(1.73205-brc); %abscisa corte con r1
          xr(2)= brc*xr(1)+arc; % ordenada corte con r1
        end
        C2=xm(xr);
        
        if (L==200) & (alfa==0)
          C2=[0 1 0];
        end
        
end
