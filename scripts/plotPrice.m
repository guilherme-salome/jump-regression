% Plots price of stock and price of market
f1 = figure;
yyaxis left;
plot(getSerialDate(sraw(:,1:2)),sraw(:,3),'LineWidth',0.5,'Color','blue');
ylabel(['Price of ' stkr ': $P_t^{' stkr '}$'],'Interpreter','latex');
hold on;
yyaxis right;
plot(getSerialDate(raw(:,1:2)),raw(:,3),'LineWidth',0.5,'Color','red'); 
ylabel(['Price of ' tkr ': $P_t^{' tkr '}$'],'Interpreter','latex');
datetick('x','yyyy');
xlabel('Date: t','Interpreter','latex');
title(['Price Evolution of ' stkr ' and ' tkr],'Interpreter','latex');
grid on;
f1l = legend({['Price of ' stkr],['Price of ' tkr]},'Interpreter','latex');
% change font size
set(findall(f1,'type','text'),'FontSize',15);
set(f1l,'FontSize',11);