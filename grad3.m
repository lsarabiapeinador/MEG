function cromatograma=grad3(answer1)

% dibuja y rotula el triángulo de mezclas
clf(figure(1));
figure(1);
axis off;
hold on;

set(line([0,1],[0,0]),'Color',[1 0 0],'LineWidth',2);
set(line([0,0.5],[0,0.866025]),'Color',[1 0 0],'LineWidth',2);
set(line([1,0.5],[0,0.866025]),'Color',[1 0 0],'LineWidth',2);


set(text(-0.05,-0.05,'MeOH'),'Color',[0 0.75 0],'FontSize',14);
set(text(0.45,0.916025,'H_2O'),'Color',[0 0.75 0],'FontSize',14);
set(text(0.95,-0.05,'ACN'),'Color',[0 0.75 0],'FontSize',14);

for i=0.9:-0.1:0.1
    x1=mx([i 1-i 0]);
    x2=mx([i 0 1-i]);

    set(line([x1(1),x2(1)],[x1(2),x2(2)]),'Color',[0.85 0.85 0.85],'LineWidth',0.5);
end

for i=0.9:-0.1:0.1
    x1=mx([1-i 0 i]);
    x2=mx([0 1-i i]);

    set(line([x1(1),x2(1)],[x1(2),x2(2)]),'Color',[0.85 0.85 0.85],'LineWidth',0.5);
end

for i=0.9:-0.1:0.1
    x1=mx([0 i 1-i]);
    x2=mx([1-i i 0]);

    set(line([x1(1),x2(1)],[x1(2),x2(2)]),'Color',[0.85 0.85 0.85],'LineWidth',0.5);
end


C1=str2num(answer1{2});
C1=(C1./100)';
C2=str2num(answer1{3});
C2=(C2./100)';
Y1=str2num(answer1{4});
[~,ng]=size(Y1);


if (C1(1)==C2(1))&& (C1(2)< C2(2))
    bandera=-1;
elseif (C1(1)==C2(1))&& (C1(2)> C2(2))
    bandera=0;

elseif (C1(1)~= C2(1))
    bandera=+1;
end
    

switch bandera
    case -1
        for i=1:ng
          k=C1(2)+(i-1)*(C2(2)-C1(2))/(ng-1);
          C(i,2)=k;
          C(i,1)=C1(1);
          C(i,3)= 1-C(i,1)-C(i,2);
          CR=round(C,4);
          X=mx(CR(i,:));
          if Y1(i)~= 0
            figure(1);plot(X(:,1),X(:,2),'o','Color',[0 0 0])
          end
        end
        
    case 0
        for i=1:ng
          k=C1(2)- (i-1)*(C1(2)-C2(2))/(ng-1);
          C(i,2)=k;
          C(i,1)=C1(1);
          C(i,3)= 1-C(i,1)-C(i,2);
          CR=round(C,4);
          X=mx(CR(i,:));
          if Y1(i)~= 0
            figure(1);plot(X(:,1),X(:,2),'o','Color',[0 0 0])
          end
        end
      
    case +1
        for i=1:ng
            k=C1(1)+(i-1)*(C2(1)-C1(1))/(ng-1);
            C(i,1)=k;
            l=(k-C2(1))/(C1(1)-C2(1));
            C(i,2)= C1(2)*l+C2(2)*(1-l);
            % C(i,3)=C1(3)*l+C2(3)*(1-l);
            C(i,3)=1-C(i,1)-C(i,2);
            CR=round(C,4);
            X=mx(CR(i,:));
            if Y1(i)~= 0
                figure(1);plot(X(:,1),X(:,2),'o','Color',[0 0 0])
            end
        end
end
        
 CT=CR*100;
CT=round(CT,1);

% tiempos acumulados
Y2=Y1;
for i=2:ng
    Y2(i)=Y2(i-1)+Y1(i);
end
CTF=[Y1' Y2' CT];
T=array2table(CTF,'VariableNames',{'min', 'min_ac','Water','MeOH','ACN'});
figure(1);

TT=answer1{1};
text(-0.05,0.92,TT,'Color',[0 0 0],'FontSize',14);

fig=gcf;
fig.Position=[19,255,560,420];

figure(1);hold off

% savefig('cromatograma');
% cromatograma.L=L;
% cromatograma.alfa=alfa;
% cromatograma.t_subintervalo=t;
% cromatograma.n_subintervalos=ng;
% cromatograma.t_maximo=tmax;
cromatograma.nombre=TT;
cromatograma.tabla=T;


% maneja datatip interactivamente
dcm = datacursormode;
dcm.Enable = 'on';
dcm.UpdateFcn = @displayCoordinates; 
end

function txt = displayCoordinates(~,info)
    x = info.Position(1);
    y = info.Position(2);
    c=xm([x y])*100;
    c=round(c,1);
    txt = {['H_2O: '  num2str(c(1))] ; [ 'MeOH: ' num2str(c(2))] ;['ACN: '  num2str(c(3))]};

end

