function plot_band(data_1)
    data = data_1/1000;
    n=3;
    %figure('Position',[0 0 500 300])
    fig=figure('units','inch','position',[0,0,4,2*4.0/3]);
    band1=(data');
    band2=band1;
    plot(band2,'b','LineWidth',2)

    xticks([1 10 20 30])
    xticklabels({'\Gamma','X','M','\Gamma'})
    ylabel('Frequency [kHz]','FontSize',12)
    xlabel('Wave vector','FontSize',12)
    xlim([1 30]);
    ylim([0 max(max(band2))])
    
    
    %for i =1:length(data(:,1))-1
    maximo=max(band2(:,n));
    minimo=min(band2(:,n+1));
    delta = minimo-maximo;
    media = (maximo+minimo)/2;
        
        %if delta >0 && delta >0.5
        
    disp(strcat('band = ',num2str(n)))
    disp(strcat('bandgap relativo ',num2str(delta/media)))
    disp(strcat('bandgap medio',num2str(media)))
    disp(strcat('bandgap absoluto',num2str(delta)))
    hold on
    txt = {strcat('$\Delta\omega =$ ',num2str(round(delta,2)),' [kHz]')};
    text(10,media,txt,'Interpreter','latex','FontSize',12)

    fill([0 30 30 0],[minimo minimo maximo maximo],'k','LineStyle','none')
    alpha(0.25)
            
        %end 
        
    %end 
    grid
    %set(gca,'fontsize',14)
    hold on 
    plot(ones(30,1)*maximo,'k','LineWidth',0.1)
    hold on 
    plot(ones(30,1)*minimo,'k','LineWidth',0.1)
end 