function grafgrad(cromatograma)

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

CTF=table2array(cromatograma.tabla);

TF=isfield(cromatograma,'L');
if TF==1
    L=cromatograma.L;
    alfa=cromatograma.alfa;
    ng=cromatograma.n_subintervalos;
else
    [ng,~]=size(CTF);
end

[~, columnas]= size(CTF);
if columnas==4
    C=CTF(:,2:4)./100;
else
    C=CTF(:, 3:5)./100;
end
Y1=CTF(:,1);
for i=1:ng
    X=mx(C(i,:));
    if Y1(i)~= 0
        figure(1);plot(X(:,1),X(:,2),'o','Color',[0 0 0]);
    end
end

if TF==1
    TT=['L = ',num2str(L), '  \alpha = ', num2str(alfa),'\circ'];
    text(-0.05,0.92,TT,'Color',[0 0 0],'FontSize',14);
else
    TT=cromatograma.nombre;
    text(-0.05,0.92,TT,'Color',[0 0 0],'FontSize',14);

end
text(-0.05,0.92,TT,'Color',[0 0 0],'FontSize',14);

fig=gcf;
fig.Position=[19,255,560,420];

figure(1); hold off

 dcm = datacursormode;
 dcm.Enable = 'on';
 dcm.UpdateFcn = @displayCoordinates; 
end

function txt = displayCoordinates(~,info)
    x = info.Position(1);
    y = info.Position(2);
    c=xm([x y])*100;
    c=round(c,2);
    txt = {['H_2O: '  num2str(c(1))] ; [ 'MeOH: ' num2str(c(2))] ;['ACN: '  num2str(c(3))]};

end



