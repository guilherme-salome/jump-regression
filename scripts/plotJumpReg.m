% Plots stock returns against market jump returns, and the estimated jump
% regression line
f2 = figure;
scatter(ret(jump_loc),sret(jump_loc),10,'o','filled','red');
xlabel(['Market jump return: ' '$r_t^{d,' tkr '}$'],'Interpreter','latex');
ylabel(['Stock return: ' '$r_t^{' stkr '}$'],'Interpreter','latex');
title('Market Jump Return Effect on Stock Return','Interpreter','latex');
x_grid = 1.1*min(ret(jump_loc)):0.01:1.1*max(ret(jump_loc));
hold on; grid on;
plot(x_grid,beta.*x_grid,'LineWidth',1,'Color','blue');
plot(NaN,NaN,'-s','MarkerFaceColor','yellow');
f2l = legend({[tkr ' return vs. ' stkr ' jump return'],['Jump Regression: $\hat{r}_t^{' stkr '}=\hat{\beta}_{jump}r_t^{d,' tkr '}$'],['$\hat{\beta}_{jump}=' num2str(beta) '$, CI:[' num2str(CI_low) ',' num2str(CI_up) '], $H_0^{5\%}$: ' rej]},'Interpreter','latex','Location','northwest');
% change font size
set(findall(f2,'type','text'),'FontSize',15);
set(f2l,'FontSize',11);

