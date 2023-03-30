 clc;
clear ALL;

%%   parameters   %%%%%%%% 

global gamma_0 mu beta_0 gamma_e_step gamma_e_last u_step 
gamma_0=0.1;         %%% recovery rate
beta_0=0.8;          %%% transmission rate
mu=1/(70*365);       %%% natural birth-death rate

gamma_e_step=0.01;          %%% step length of gamma_e
gamma_e_last=6;            %%% last value of gamma_e
u_step=0.0005;             %%% step length of u

figure;

%%   analytical results   %%%%%%%%%%%%

for beta_e=[2 3 4 5];   %%% particular values of beta_e
     L1=0;
     n=numel(0:gamma_e_step:gamma_e_last);
     u_opt=[];
     u_long=[];       %% optimal resource from analytical results
     
for i=1:n
    gamma_e=0+(i-1)*gamma_e_step;
    u=(beta_e.*(gamma_0+gamma_0*gamma_e+mu)-sqrt(beta_0*gamma_0*beta_e.*gamma_e))./(gamma_0*beta_e.*gamma_e);
    if u>=1
        u_opt(i)=1;
    else if u>0 && u<1
         u_opt(i)=u;
         else u_opt(i)=0;
        end
    end

      R_0=beta_0./((1+beta_e*u_opt(i)).*(gamma_0*(1+gamma_e*(1-u_opt(i)))+mu)); %% basic reproduction number
   if R_0>=1 
       u_long(i)=u_opt(i);
   end
end

L1=length(u_long);
gamma_e=0:gamma_e_step:gamma_e_last;
plot(gamma_e(1:L1),u_long,'linewidth',5)
hold on
end

%% axis %%%%%%%%%%%%%%%%%
xlim([-0.2 6.2])   
ylim([-0.035 1.035])
set(findall(gcf,'-property','FontSize'),'FontName','Helvetica','FontSize',35,'fontweight','b')   
xlabel('\boldmath$\gamma_{e}$','Interpreter','LaTeX','FontSize',35)
ylabel('\boldmath$u_{\rm long}^{*}$','Interpreter','LaTeX','FontSize',35)
axis square

set(gca,'XTick',[0 2 4 6 8]);   %%% tick location
set(gca,'XTickLabel',{'$\bf{0}$','$\bf{2}$','$\bf{4}$', '$\bf{6}$', '$\bf{8}$'}); % tick labels
set(gca,'TickLabelInterpreter','latex')
set(gca,'YTick',[0 0.25 0.50 0.75 1]);
set(gca,'YTickLabel',{'$\bf{0}$','$\bf{0.25}$','$\bf{0.50}$','$\bf{0.75}$', '$\bf{1}$' })

set(gca,'ticklength',2*get(gca,'ticklength'))
set(gca,'linewidth',2)

legend('\boldmath$\beta_e$=\bf2','\boldmath$\beta_e$=\bf3','\boldmath$\beta_e$=\bf4','\boldmath$\beta_e$=\bf5')
set(legend,'Interpreter','LaTeX','FontSize',25 )
set(legend,'color','none');
set(legend, 'Box', 'off');

