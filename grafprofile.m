function grafprofile(cromatograma)

clf(figure(2));
t=cromatograma.tabla.min;
Me=cromatograma.tabla.MeOH;
Ac=cromatograma.tabla.ACN;
[ng,~]=size(t); % número de pasos

for i=1:ng
    st(i)=sum(t([1:i],:));
end
bndMe=0;
if sum(Me) ~= 0
bndMe=1;  % hay Me  
    % tramos horizontales Me
    figure(2);
    line([0 st(1)],[Me(1) Me(1)],'Color','r','LineWidth',2);
    for i=2:ng
        line([st(i-1) st(i)], [Me(i) Me(i)],'Color','r','LineWidth',2)
    end
hold on

    
% tramos verticales Me
    for i=1:ng-1
        line([st(i) st(i)], [Me(i) Me(i+1)],'Color','r','LineWidth',2)
    end

end
bndAc=0;
if sum(Ac) ~= 0
bndAc=1; % hay Ac   
% tramos horizontales Ac
figure(2);
line([0 st(1)],[Ac(1) Ac(1)],'Color','g','LineWidth',2);
for i=2:ng
    line([st(i-1) st(i)], [Ac(i) Ac(i)],'Color','g','LineWidth',2)
end
hold on

    
% tramos verticales Ac
for i=1:ng-1
    line([st(i) st(i)], [Ac(i) Ac(i+1)],'Color','g','LineWidth',2)
end
end


grid on

if bndMe==0
    title(['\color{green}  % ACN'], 'fontsize',14)

elseif bndAc==0
    title(['\color{red}% MeOH '], 'fontsize',14)
else
    title(['\color{red}% MeOH \color{green}  % ACN'], 'fontsize',14)
end

ax = gca;
ax.XAxis.Label.FontSize = 14;
ax.XAxis.FontSize = 12;
xlabel('Time / min');

ax.YAxis.Label.FontSize = 14;
ax.YAxis.FontSize = 12;
ylabel('Percent of modifier');

fig=gcf;
fig.Position=[619,255,560,420];


hold off
end

