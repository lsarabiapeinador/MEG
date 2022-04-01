
clf(figure(1));
figure(1);
axis off;
hold on;

set(line([0,1],[0,0]),'Color',[0.80 0.80 0.80],'LineWidth',3);
set(line([0,0.5],[0,0.866025]),'Color',[0.80 0.80 0.80],'LineWidth',3);
set(line([1,0.5],[0,0.866025]),'Color',[0.80 0.80 0.80],'LineWidth',3);


set(text(-0.05,-0.05,'MeOH'),'Color',[0 0 0],'FontSize',14);
set(text(0.45,0.916025,'H_2O'),'Color',[0 0 0],'FontSize',14);
set(text(0.95,-0.05,'ACN'),'Color',[0 0 0],'FontSize',14);

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
figure(1)
hold off
clear x1 x2 i

dcm = datacursormode;
dcm.Enable = 'on';
dcm.UpdateFcn = @displayCoordinates; 


function txt = displayCoordinates(~,info)
    x = info.Position(1);
    y = info.Position(2);
    c=xm([x y])*100;
    c=round(c,2);
    txt = {['H_2O: '  num2str(c(1))] ; [ 'MeOH: ' num2str(c(2))] ;['ACN: '  num2str(c(3))]};

end

