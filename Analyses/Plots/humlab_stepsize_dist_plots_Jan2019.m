clear all
clc
set(0,'defaulttextinterpreter','tex') %set default text interpreter to tex

%raw data plots:
%fig()
%subplot(1-4): CHN WR (pitch, amp, space, time steps) (c1-c4)
%CHN WR LENA -> blue
%CHN WR HUM -> pink
%subplot(5-8): CHN WOR (") (c5-c8)
%CHN WOR LENA -> red
%CHN WOR HUM -> grey

clear all
%pitch plots
for sec = 1
    
%CHN plot    
    %human labeled data - raw data
    load('adresp2ch_stepsizes_humlab.mat')
    
    for i = 1:length(HUM_idage) 
    figure(i)   %1 figure for each human listener
    set(gcf,'color','w');
    axes1 = subplot(2,4,1);
    title(HUM_idage{i}) %label is human listener + child id + child age

    % Create ylabel
    ylabel('\bf{Probability Density (raw data)}','Interpreter','tex','FontSize',33);

    hold all
    
    %LENA data
    %CHN WR LENA - blue
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAad_distf{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAad_distf{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'DisplayName','\bf{Ch-LENA-WR (d)}','LineWidth',2,'LineStyle','-',...
    'Color','b');
    end
    end
    
    %CHN WR HUM - magenta
    [aic_fad,ffit,p] = aicnew(HUMad_distf{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMad_distf{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'DisplayName','\bf{HUM-WR (d)}','LineWidth',2,'LineStyle','-',...
    'Color',[1 0 1]);

    % Create legend
    legend1 = legend(axes1,'show');
    set(legend1,...
    'Position',[0.359408010321868 0.929734148908041 0.336666666666667 0.068352059925094],...
    'Orientation','horizontal',...
    'Interpreter','tex',...
    'FontSize',27,...
    'FontName','Helvetica Neue');

    axes2 = subplot(2,4,5);
    hold all
    title('\bf{(c5)}')
    
    %CHN WOR LENA - red
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAnoad_distf{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAnoad_distf{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'DisplayName','\bf{Ch-LENA-WOR (d)}','LineWidth',2,'LineStyle','-',...
    'Color','r');
    end
    end
    
    %CHN WOR HUM - grey
    [aic_fad,ffit,p] = aicnew(HUMnoad_distf{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMnoad_distf{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'DisplayName','\bf{HUM-WOR (d)}','LineWidth',2,'LineStyle','-',...
    'Color',[.7 .7 .7]);
    
    % Create xlabel
    xlabel('\bf{Pitch s.z.}','Interpreter','tex','FontSize',33);

    % Create legend
    legend1 = legend(axes2,'show');
    set(legend1,...
    'Position',[0.3432 0.4615 0.3678 0.0684],...
    'Orientation','horizontal',...
    'Interpreter','tex',...
    'FontSize',27,...
    'FontName','Helvetica Neue');
    
    % Set the remaining axes properties
    set(axes1,'FontSize',30,'YMinorTick','on','YScale','linear');
    set(axes2,'FontSize',30,'YMinorTick','on','YScale','linear');
    

    end
     
end

clear all
%amplitude plots
for sec = 1
    
%CHN plot    
    %human labeled data - raw data
    load('adresp2ch_stepsizes_humlab.mat')
    
    for i = 1:length(HUM_idage) 
    figure(i)   %1 figure for each human listener
    set(gcf,'color','w');
    axes1 = subplot(2,4,2);
    title('\bf{(c2)}') %label is human listener + child id + child age
    
    hold all
    
    %LENA data
    %CHN WR LENA - blue
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAad_distd{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAad_distd{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-','Color','b');
    end
    end
    
    %CHN WR HUM - magenta
    [aic_fad,ffit,p] = aicnew(HUMad_distd{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMad_distd{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-','Color',[1 0 1]);


    axes2 = subplot(2,4,6);
    hold all
    title('\bf{(c6)}')
    
    %CHN WOR LENA - red
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAnoad_distd{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAnoad_distd{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-',...
    'Color','r');
    end
    end
    
    %CHN WOR HUM - grey
    [aic_fad,ffit,p] = aicnew(HUMnoad_distd{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMnoad_distd{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-',...
    'Color',[.7 .7 .7]);

    % Create xlabel
    xlabel('\bf{Amplitude s.z.}','Interpreter','tex','FontSize',33);
    
    % Set the remaining axes properties
    set(axes1,'FontSize',30,'YMinorTick','on','YScale','linear');
    set(axes2,'FontSize',30,'YMinorTick','on','YScale','linear');
    

    end
     
end

clear all
%acoustic space plots
for sec = 1
    
%CHN plot    
    %human labeled data - raw data
    load('adresp2ch_stepsizes_humlab.mat')
    
    for i = 1:length(HUM_idage) 
    figure(i)   %1 figure for each human listener
    set(gcf,'color','w');
    axes1 = subplot(2,4,3);
    title('\bf{(c3)}') %label is human listener + child id + child age
    
    hold all
    
    %LENA data
    %CHN WR LENA - blue
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAad_distsp{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAad_distsp{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-','Color','b');
    end
    end
    
    %CHN WR HUM - magenta
    [aic_fad,ffit,p] = aicnew(HUMad_distsp{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMad_distsp{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-','Color',[1 0 1]);


    axes2 = subplot(2,4,7);
    hold all
    title('\bf{(c7)}')
    
    %CHN WOR LENA - red
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAnoad_distsp{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAnoad_distsp{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-',...
    'Color','r');
    end
    end
    
    %CHN WOR HUM - grey
    [aic_fad,ffit,p] = aicnew(HUMnoad_distsp{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMnoad_distsp{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-',...
    'Color',[.7 .7 .7]);

    % Create xlabel
    xlabel('\bf{Acoustic sp. s.z.}','Interpreter','tex','FontSize',33);
    
    % Set the remaining axes properties
    set(axes1,'FontSize',30,'YMinorTick','on','YScale','linear');
    set(axes2,'FontSize',30,'YMinorTick','on','YScale','linear');
    

    end
     
end

clear all
%Time plots
for sec = 1
    
%CHN plot    
    %human labeled data - raw data
    load('adresp2ch_stepsizes_humlab.mat')
    
    for i = 1:length(HUM_idage) 
    figure(i)   %1 figure for each human listener
    set(gcf,'color','w');
    axes1 = subplot(2,4,4);
    title('\bf{(c4)}') %label is human listener + child id + child age
    
    hold all
    
    %LENA data
    %CHN WR LENA - blue
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAad_distt{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAad_distt{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-','Color','b');
    end
    end
    
    %CHN WR HUM - magenta
    [aic_fad,ffit,p] = aicnew(HUMad_distt{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMad_distt{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-','Color',[1 0 1]);


    axes2 = subplot(2,4,8);
    hold all
    title('\bf{(c8)}')
    
    %CHN WOR LENA - red
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAnoad_distt{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAnoad_distt{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-',...
    'Color','r');
    end
    end
    
    %CHN WOR HUM - grey
    [aic_fad,ffit,p] = aicnew(HUMnoad_distt{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMnoad_distt{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-',...
    'Color',[.7 .7 .7]);

    % Create xlabel
    xlabel('\bf{Intervoc. Int. (s)}','Interpreter','tex','FontSize',33);
    
    % Set the remaining axes properties
    set(axes1,'FontSize',30,'YMinorTick','on','YScale','linear');
    set(axes2,'FontSize',30,'YMinorTick','on','YScale','linear');
    

    end
     
end

%----------------------------------------
%raw data plots
%fig()
%subplot(1-4): AD WR (pitch, amp, space, time steps) (d1-d4)
%ad WR LENA -> black
%ad WR HUM -> pink
%subplot(5-8): CHN WOR (") (d5-d8)
%ad WOR LENA -> green
%ad WOR HUM -> grey

clear all
%pitch plots
for sec = 1
    
%AD plot    
    %human labeled data - raw data
    load('chresp2ad_stepsizes_humlab.mat')
    
    for i = 1:length(HUM_idage) 
    figure(i + 4)   %1 figure for each human listener
    set(gcf,'color','w');
    axes1 = subplot(2,4,1);
    title(HUM_idage{i}) %label is human listener + child id + child age

    hold all
    
    %LENA data
    %AD WR LENA - black
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAch_distf{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAch_distf{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'DisplayName','\bf{Ad-LENA-WR (d)}','LineWidth',2,'LineStyle','-',...
    'Color','k');
    end
    end
    
    %AD WR HUM - magenta
    [aic_fad,ffit,p] = aicnew(HUMch_distf{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMch_distf{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'DisplayName','\bf{HUM-WR (d)}','LineWidth',2,'LineStyle','-',...
    'Color',[1 0 1]);

    % Create legend
    legend1 = legend(axes1,'show');
    set(legend1,...
    'Position',[0.359408010321868 0.929734148908041 0.336666666666667 0.068352059925094],...
    'Orientation','horizontal',...
    'Interpreter','tex',...
    'FontSize',27,...
    'FontName','Helvetica Neue');

    axes2 = subplot(2,4,5);
    hold all
    title('\bf{(d5)}')
    
    %AD WOR LENA - green
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAnoch_distf{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAnoch_distf{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'DisplayName','\bf{Ad-LENA-WOR (d)}','LineWidth',2,'LineStyle','-',...
    'Color','g');
    end
    end
    
    %AD WOR HUM - grey
    [aic_fad,ffit,p] = aicnew(HUMnoch_distf{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMnoch_distf{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'DisplayName','\bf{HUM-WOR (d)}','LineWidth',2,'LineStyle','-',...
    'Color',[.7 .7 .7]);
    
    % Create xlabel
    xlabel('\bf{Pitch s.z.}','Interpreter','tex','FontSize',33);

    % Create legend
    legend1 = legend(axes2,'show');
    set(legend1,...
    'Position',[0.3432 0.4615 0.3678 0.0684],...
    'Orientation','horizontal',...
    'Interpreter','tex',...
    'FontSize',27,...
    'FontName','Helvetica Neue');
    
    % Set the remaining axes properties
    set(axes1,'FontSize',30,'YMinorTick','on','YScale','linear');
    set(axes2,'FontSize',30,'YMinorTick','on','YScale','linear');
    

    end
     
end

clear all
%amplitude plots
for sec = 1
    
%AD plot    
    %human labeled data - raw data
    load('chresp2ad_stepsizes_humlab.mat')
    
    for i = 1:length(HUM_idage) 
    figure(i + 4)   %1 figure for each human listener
    set(gcf,'color','w');
    axes1 = subplot(2,4,2);
    title('\bf{(d2)}') %label is human listener + child id + child age
    
    hold all
    
    %LENA data
    %AD WR LENA - black
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAch_distd{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAch_distd{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-','Color','k');
    end
    end
    
    %AD WR HUM - magenta
    [aic_fad,ffit,p] = aicnew(HUMch_distd{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMch_distd{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-','Color',[1 0 1]);


    axes2 = subplot(2,4,6);
    hold all
    title('\bf{(d6)}')
    
    %AD WOR LENA - green
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAnoch_distd{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAnoch_distd{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-',...
    'Color','g');
    end
    end
    
    %AD WOR HUM - grey
    [aic_fad,ffit,p] = aicnew(HUMnoch_distd{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMnoch_distd{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-',...
    'Color',[.7 .7 .7]);

    % Create xlabel
    xlabel('\bf{Amplitude s.z.}','Interpreter','tex','FontSize',33);
    
    % Set the remaining axes properties
    set(axes1,'FontSize',30,'YMinorTick','on','YScale','linear');
    set(axes2,'FontSize',30,'YMinorTick','on','YScale','linear');
    

    end
     
end

clear all
%acoustic space plots
for sec = 1
    
%AD plot    
    %human labeled data - raw data
    load('chresp2ad_stepsizes_humlab.mat')
    
    for i = 1:length(HUM_idage) 
    figure(i + 4)   %1 figure for each human listener
    set(gcf,'color','w');
    axes1 = subplot(2,4,3);
    title('\bf{(d3)}') %label is human listener + child id + child age
    
    hold all
    
    %LENA data
    %AD WR LENA - black
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAch_distsp{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAch_distsp{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-','Color','k');
    end
    end
    
    %AD WR HUM - magenta
    [aic_fad,ffit,p] = aicnew(HUMch_distsp{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMch_distsp{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-','Color',[1 0 1]);


    axes2 = subplot(2,4,7);
    hold all
    title('\bf{(d7)}')
    
    %AD WOR LENA - green
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAnoch_distsp{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAnoch_distsp{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-',...
    'Color','g');
    end
    end
    
    %AD WOR HUM - grey
    [aic_fad,ffit,p] = aicnew(HUMnoch_distsp{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMnoch_distsp{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-',...
    'Color',[.7 .7 .7]);

    % Create xlabel
    xlabel('\bf{Acoustic sp. s.z.}','Interpreter','tex','FontSize',33);
    
    % Set the remaining axes properties
    set(axes1,'FontSize',30,'YMinorTick','on','YScale','linear');
    set(axes2,'FontSize',30,'YMinorTick','on','YScale','linear');
    

    end
     
end

clear all
%Time plots
for sec = 1
    
%AD plot    
    %human labeled data - raw data
    load('chresp2ad_stepsizes_humlab.mat')
    
    for i = 1:length(HUM_idage) 
    figure(i + 4)   %1 figure for each human listener
    set(gcf,'color','w');
    axes1 = subplot(2,4,4);
    title('\bf{(d4)}') %label is human listener + child id + child age
    
    hold all
    
    %LENA data
    %AD WR LENA - black
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAch_distt{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAch_distt{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-','Color','k');
    end
    end
    
    %AD WR HUM - magenta
    [aic_fad,ffit,p] = aicnew(HUMch_distt{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMch_distt{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-','Color',[1 0 1]);


    axes2 = subplot(2,4,8);
    hold all
    title('\bf{(d8)}')
    
    %AD WOR LENA - green
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAnoch_distt{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAnoch_distt{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-',...
    'Color','g');
    end
    end
    
    %AD WOR HUM - grey
    [aic_fad,ffit,p] = aicnew(HUMnoch_distt{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMnoch_distt{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_dat/Area,'LineWidth',2,'LineStyle','-',...
    'Color',[.7 .7 .7]);

    % Create xlabel
    xlabel('\bf{Intervoc. Int. (s)}','Interpreter','tex','FontSize',33);
    
    % Set the remaining axes properties
    set(axes1,'FontSize',30,'YMinorTick','on','YScale','linear');
    set(axes2,'FontSize',30,'YMinorTick','on','YScale','linear');
    

    end
     
end

%----------------------------------------

%fit plots: same but dotted lines
%fig()
%subplot(1-4): CHN WR (pitch, amp, space, time steps) (e1-e4)
%CHN WR LENA -> blue
%CHN WR HUM -> pink
%subplot(5-8): CHN WOR (") (e5-e8)
%CHN WOR LENA -> red
%CHN WOR HUM -> grey

clear all
%pitch plots
for sec = 1
    
%CHN plot    
    %human labeled data - raw data
    load('adresp2ch_stepsizes_humlab.mat')
    
    for i = 1:length(HUM_idage) 
    figure(i + 8)   %1 figure for each human listener
    set(gcf,'color','w');
    axes1 = subplot(2,4,1);
    title(HUM_idage{i}) %label is human listener + child id + child age

    % Create ylabel
    ylabel('\bf{Probability Density (fit)}','Interpreter','tex','FontSize',33);

    hold all
    
    %LENA data
    %CHN WR LENA - blue
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAad_distf{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAad_distf{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'DisplayName','\bf{Ch-LENA-WR (f)}','LineWidth',2,'LineStyle','--',...
    'Color','b');
    end
    end
    
    %CHN WR HUM - magenta
    [aic_fad,ffit,p] = aicnew(HUMad_distf{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMad_distf{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'DisplayName','\bf{HUM-WR (f)}','LineWidth',2,'LineStyle','--',...
    'Color',[1 0 1]);

    % Create legend
    legend1 = legend(axes1,'show');
    set(legend1,...
    'Position',[0.359408010321868 0.929734148908041 0.336666666666667 0.068352059925094],...
    'Orientation','horizontal',...
    'Interpreter','tex',...
    'FontSize',27,...
    'FontName','Helvetica Neue');

    axes2 = subplot(2,4,5);
    hold all
    title('\bf{(e5)}')
    
    %CHN WOR LENA - red
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAnoad_distf{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAnoad_distf{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'DisplayName','\bf{Ch-LENA-WOR (f)}','LineWidth',2,'LineStyle','--',...
    'Color','r');
    end
    end
    
    %CHN WOR HUM - grey
    [aic_fad,ffit,p] = aicnew(HUMnoad_distf{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMnoad_distf{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'DisplayName','\bf{HUM-WOR (f)}','LineWidth',2,'LineStyle','--',...
    'Color',[.7 .7 .7]);
    
    % Create xlabel
    xlabel('\bf{Pitch s.z.}','Interpreter','tex','FontSize',33);

    % Create legend
    legend1 = legend(axes2,'show');
    set(legend1,...
    'Position',[0.3432 0.4615 0.3678 0.0684],...
    'Orientation','horizontal',...
    'Interpreter','tex',...
    'FontSize',27,...
    'FontName','Helvetica Neue');
    
    % Set the remaining axes properties
    set(axes1,'FontSize',30,'YMinorTick','on','YScale','linear');
    set(axes2,'FontSize',30,'YMinorTick','on','YScale','linear');
    

    end
     
end

clear all
%amplitude plots
for sec = 1
    
%CHN plot    
    %human labeled data - raw data
    load('adresp2ch_stepsizes_humlab.mat')
    
    for i = 1:length(HUM_idage) 
    figure(i+8)   %1 figure for each human listener
    set(gcf,'color','w');
    axes1 = subplot(2,4,2);
    title('\bf{(e2)}') %label is human listener + child id + child age
    
    hold all
    
    %LENA data
    %CHN WR LENA - blue
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAad_distd{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAad_distd{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--','Color','b');
    end
    end
    
    %CHN WR HUM - magenta
    [aic_fad,ffit,p] = aicnew(HUMad_distd{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMad_distd{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--','Color',[1 0 1]);


    axes2 = subplot(2,4,6);
    hold all
    title('\bf{(e6)}')
    
    %CHN WOR LENA - red
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAnoad_distd{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAnoad_distd{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--',...
    'Color','r');
    end
    end
    
    %CHN WOR HUM - grey
    [aic_fad,ffit,p] = aicnew(HUMnoad_distd{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMnoad_distd{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--',...
    'Color',[.7 .7 .7]);

    % Create xlabel
    xlabel('\bf{Amplitude s.z.}','Interpreter','tex','FontSize',33);
    
    % Set the remaining axes properties
    set(axes1,'FontSize',30,'YMinorTick','on','YScale','linear');
    set(axes2,'FontSize',30,'YMinorTick','on','YScale','linear');
    

    end
     
end

clear all
%acoustic space plots
for sec = 1
    
%CHN plot    
    %human labeled data - raw data
    load('adresp2ch_stepsizes_humlab.mat')
    
    for i = 1:length(HUM_idage) 
    figure(i+8)   %1 figure for each human listener
    set(gcf,'color','w');
    axes1 = subplot(2,4,3);
    title('\bf{(e3)}') %label is human listener + child id + child age
    
    hold all
    
    %LENA data
    %CHN WR LENA - blue
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAad_distsp{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAad_distsp{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--','Color','b');
    end
    end
    
    %CHN WR HUM - magenta
    [aic_fad,ffit,p] = aicnew(HUMad_distsp{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMad_distsp{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--','Color',[1 0 1]);


    axes2 = subplot(2,4,7);
    hold all
    title('\bf{(e7)}')
    
    %CHN WOR LENA - red
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAnoad_distsp{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAnoad_distsp{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--',...
    'Color','r');
    end
    end
    
    %CHN WOR HUM - grey
    [aic_fad,ffit,p] = aicnew(HUMnoad_distsp{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMnoad_distsp{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--',...
    'Color',[.7 .7 .7]);

    % Create xlabel
    xlabel('\bf{Acoustic sp. s.z.}','Interpreter','tex','FontSize',33);
    
    % Set the remaining axes properties
    set(axes1,'FontSize',30,'YMinorTick','on','YScale','linear');
    set(axes2,'FontSize',30,'YMinorTick','on','YScale','linear');
    

    end
     
end

clear all
%Time plots
for sec = 1
    
%CHN plot    
    %human labeled data - raw data
    load('adresp2ch_stepsizes_humlab.mat')
    
    for i = 1:length(HUM_idage) 
    figure(i+8)   %1 figure for each human listener
    set(gcf,'color','w');
    axes1 = subplot(2,4,4);
    title('\bf{(e4)}') %label is human listener + child id + child age
    
    hold all
    
    %LENA data
    %CHN WR LENA - blue
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAad_distt{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAad_distt{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--','Color','b');
    end
    end
    
    %CHN WR HUM - magenta
    [aic_fad,ffit,p] = aicnew(HUMad_distt{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMad_distt{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--','Color',[1 0 1]);


    axes2 = subplot(2,4,8);
    hold all
    title('\bf{(e8)}')
    
    %CHN WOR LENA - red
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAnoad_distt{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAnoad_distt{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--',...
    'Color','r');
    end
    end
    
    %CHN WOR HUM - grey
    [aic_fad,ffit,p] = aicnew(HUMnoad_distt{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMnoad_distt{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--',...
    'Color',[.7 .7 .7]);

    % Create xlabel
    xlabel('\bf{Intervoc. Int. (s)}','Interpreter','tex','FontSize',33);
    
    % Set the remaining axes properties
    set(axes1,'FontSize',30,'YMinorTick','on','YScale','linear');
    set(axes2,'FontSize',30,'YMinorTick','on','YScale','linear');
    

    end
     
end

%----------------------------------------

%fig()
%subplot(1-4): AD WR (pitch, amp, space, time steps) (f1-f4)
%ad WR LENA -> black
%ad WR HUM -> pink
%subplot(5-8): CHN WOR (") (f5-f8)
%ad WOR LENA -> green
%ad WOR HUM -> grey

clear all
%pitch plots
for sec = 1
    
%AD plot    
    %human labeled data - raw data
    load('chresp2ad_stepsizes_humlab.mat')
    
    for i = 1:length(HUM_idage) 
    figure(i + 12)   %1 figure for each human listener
    set(gcf,'color','w');
    axes1 = subplot(2,4,1);
    title(HUM_idage{i}) %label is human listener + child id + child age

    hold all
    
    %LENA data
    %AD WR LENA - black
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAch_distf{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAch_distf{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'DisplayName','\bf{Ad-LENA-WR (f)}','LineWidth',2,'LineStyle','--',...
    'Color','k');
    end
    end
    
    %AD WR HUM - magenta
    [aic_fad,ffit,p] = aicnew(HUMch_distf{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMch_distf{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'DisplayName','\bf{HUM-WR (f)}','LineWidth',2,'LineStyle','--',...
    'Color',[1 0 1]);

    % Create legend
    legend1 = legend(axes1,'show');
    set(legend1,...
    'Position',[0.359408010321868 0.929734148908041 0.336666666666667 0.068352059925094],...
    'Orientation','horizontal',...
    'Interpreter','tex',...
    'FontSize',27,...
    'FontName','Helvetica Neue');

    axes2 = subplot(2,4,5);
    hold all
    title('\bf{(f5)}')
    
    %AD WOR LENA - green
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAnoch_distf{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAnoch_distf{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'DisplayName','\bf{Ad-LENA-WOR (f)}','LineWidth',2,'LineStyle','--',...
    'Color','g');
    end
    end
    
    %AD WOR HUM - grey
    [aic_fad,ffit,p] = aicnew(HUMnoch_distf{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMnoch_distf{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'DisplayName','\bf{HUM-WOR (f)}','LineWidth',2,'LineStyle','--',...
    'Color',[.7 .7 .7]);
    
    % Create xlabel
    xlabel('\bf{Pitch s.z.}','Interpreter','tex','FontSize',33);

    % Create legend
    legend1 = legend(axes2,'show');
    set(legend1,...
    'Position',[0.3432 0.4615 0.3678 0.0684],...
    'Orientation','horizontal',...
    'Interpreter','tex',...
    'FontSize',27,...
    'FontName','Helvetica Neue');
    
    % Set the remaining axes properties
    set(axes1,'FontSize',30,'YMinorTick','on','YScale','linear');
    set(axes2,'FontSize',30,'YMinorTick','on','YScale','linear');
    

    end
     
end

clear all
%amplitude plots
for sec = 1
    
%AD plot    
    %human labeled data - raw data
    load('chresp2ad_stepsizes_humlab.mat')
    
    for i = 1:length(HUM_idage) 
    figure(i + 12)   %1 figure for each human listener
    set(gcf,'color','w');
    axes1 = subplot(2,4,2);
    title('\bf{(f2)}') %label is human listener + child id + child age
    
    hold all
    
    %LENA data
    %AD WR LENA - black
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAch_distd{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAch_distd{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--','Color','k');
    end
    end
    
    %AD WR HUM - magenta
    [aic_fad,ffit,p] = aicnew(HUMch_distd{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMch_distd{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--','Color',[1 0 1]);


    axes2 = subplot(2,4,6);
    hold all
    title('\bf{(f6)}')
    
    %AD WOR LENA - green
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAnoch_distd{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAnoch_distd{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--',...
    'Color','g');
    end
    end
    
    %AD WOR HUM - grey
    [aic_fad,ffit,p] = aicnew(HUMnoch_distd{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMnoch_distd{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--',...
    'Color',[.7 .7 .7]);

    % Create xlabel
    xlabel('\bf{Amplitude s.z.}','Interpreter','tex','FontSize',33);
    
    % Set the remaining axes properties
    set(axes1,'FontSize',30,'YMinorTick','on','YScale','linear');
    set(axes2,'FontSize',30,'YMinorTick','on','YScale','linear');
    

    end
     
end

clear all
%acoustic space plots
for sec = 1
    
%AD plot    
    %human labeled data - raw data
    load('chresp2ad_stepsizes_humlab.mat')
    
    for i = 1:length(HUM_idage) 
    figure(i + 12)   %1 figure for each human listener
    set(gcf,'color','w');
    axes1 = subplot(2,4,3);
    title('\bf{(f3)}') %label is human listener + child id + child age
    
    hold all
    
    %LENA data
    %AD WR LENA - black
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAch_distsp{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAch_distsp{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--','Color','k');
    end
    end
    
    %AD WR HUM - magenta
    [aic_fad,ffit,p] = aicnew(HUMch_distsp{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMch_distsp{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--','Color',[1 0 1]);


    axes2 = subplot(2,4,7);
    hold all
    title('\bf{(f7)}')
    
    %AD WOR LENA - green
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAnoch_distsp{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAnoch_distsp{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--',...
    'Color','g');
    end
    end
    
    %AD WOR HUM - grey
    [aic_fad,ffit,p] = aicnew(HUMnoch_distsp{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMnoch_distsp{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--',...
    'Color',[.7 .7 .7]);

    % Create xlabel
    xlabel('\bf{Acoustic sp. s.z.}','Interpreter','tex','FontSize',33);
    
    % Set the remaining axes properties
    set(axes1,'FontSize',30,'YMinorTick','on','YScale','linear');
    set(axes2,'FontSize',30,'YMinorTick','on','YScale','linear');
    

    end
     
end

clear all
%Time plots
for sec = 1
    
%AD plot    
    %human labeled data - raw data
    load('chresp2ad_stepsizes_humlab.mat')
    
    for i = 1:length(HUM_idage) 
    figure(i + 12)   %1 figure for each human listener
    set(gcf,'color','w');
    axes1 = subplot(2,4,4);
    title('\bf{(f4)}') %label is human listener + child id + child age
    
    hold all
    
    %LENA data
    %AD WR LENA - black
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAch_distt{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAch_distt{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--','Color','k');
    end
    end
    
    %AD WR HUM - magenta
    [aic_fad,ffit,p] = aicnew(HUMch_distt{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMch_distt{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--','Color',[1 0 1]);


    axes2 = subplot(2,4,8);
    hold all
    title('\bf{(f8)}')
    
    %AD WOR LENA - green
    idmat_hum = strsplit(HUM_idage{i},'_');
    for j = 1:length(LENA_idage)
    idmat_lena = strsplit(LENA_idage{j},'_');
    if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    [aic_fad,ffit,p] = aicnew(LENAnoch_distt{j},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1;
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(LENAnoch_distt{j},aicmat,0);
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--',...
    'Color','g');
    end
    end
    
    %AD WOR HUM - grey
    [aic_fad,ffit,p] = aicnew(HUMnoch_distt{i},[0 0 0 0],0);
    aicmat = zeros(1,4);
    aicmat(ffit) = 1; %the best fit index is designated as 1
    [xaxis,yaxis_fit,yaxis_dat] = aicplots(HUMnoch_distt{i},aicmat,0); %gets data for bestfit
    Area=trapz(xaxis,yaxis_dat);
    plot(xaxis,yaxis_fit/Area,'LineWidth',2,'LineStyle','--',...
    'Color',[.7 .7 .7]);

    % Create xlabel
    xlabel('\bf{Intervoc. Int. (s)}','Interpreter','tex','FontSize',33);
    
    % Set the remaining axes properties
    set(axes1,'FontSize',30,'YMinorTick','on','YScale','linear');
    set(axes2,'FontSize',30,'YMinorTick','on','YScale','linear');
    

    end
     
end

%----------------------------------------
