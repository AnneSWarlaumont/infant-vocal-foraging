clear all
clc
set(0,'defaulttextinterpreter','tex') %set default text interpreter to latex

%%
%--------------------------------------------
%plotting human and lena labelled data spaces - adult responses
clear all

load('humanlab_chdat.mat')
load('adresp_zkm_match.mat')

for i = 1:length(chage) %concatenates age, id and listener id
    id_age{i} =  sprintf('%s_%d_%s',childid{i},chage(i),listenerid{i});
end 

id_age = unique(id_age); % finds unique combinations

for i = 1:length(id_age)
    figure(i);
    set(gcf,'color','w','PaperType','<custom>','PaperSize',[49 23.7]); %one figure for one listener and child-age combo
    axes1 = axes('Position',...
    [0.13 0.198412698412698 0.334659090909091 0.674999999999999]); %human label plot in one subplot
set(axes1,'FontSize',30);
    hold all
    title(id_age{i},'Position',[-1.9675,2.0502 -1.4211e-14])
    ylabel('\bf{Amplitude}','Position',[-3.267597568559828 -0.514365431906163 -1.000000000000014])
    xlabel('\bf{Pitch}','Position',[5.005462682594946 -3.563173359451517 -1])
    for j =1:length(chage)
        catmat = sprintf('%s_%d_%s',childid{j},chage(j),listenerid{j}); %concatenates age, id, and listener id
        if strcmp(catmat,id_age{i}) == 1 %matches the unique id combos to each individual combo - so all of one kind, say, 183_82_edith, is plotted together
            f = chlogf_humlab{j};
            d = chdb_humlab{j};
            r = adresponse_humlab{j};
            
            for k = 1:length(r)-1
                if r(k) == 1 %with response - if k receives a response, them k to k+1 is magenta, human
                    quiver(f(k),d(k),f(k+1)-f(k),d(k+1)-d(k),0,'Color',[1 0 1],'LineWidth',1)
                elseif r(k) == 0 %without, human, grey
                    quiver(f(k),d(k),f(k+1)-f(k),d(k+1)-d(k),0,'Color',[.7 .7 .7],'LineWidth',1)
                end
            end
        end        
    end    
end

for i = 1:length(id_age)
    figure(i);
    axes2 = axes('Position',...
    [0.570340909090909 0.19973544973545 0.334659090909091 0.673677248677248]); %LENA label in other sub plot
    set(axes2,'FontSize',30);
    hold all
    title('adresponse')
    for j =1:length(adr_age)
        catmat = sprintf('%s_%d',adr_id{j},adr_age(j)); %concatenates id and age for lena labelled
        humspl = strsplit(id_age{i},'_'); 
        humcat = sprintf('%s_%s',humspl{1},humspl{2}); %picks out id and age from unique id_age combos for human labelled
        if strcmp(catmat,humcat) == 1 %matches with LENA - so '350_92' from lena and human are plotted side by side
            f = adr_zlogf{j};
            d = adr_zd{j};
            r = adresponse{j};
            
            for k = 1:length(r)-1
                if r(k) == 1 %with response, lena
                    quiver(f(k),d(k),f(k+1)-f(k),d(k+1)-d(k),0,'b','LineWidth',1)
                elseif r(k) == 0 %without response, lena
                    quiver(f(k),d(k),f(k+1)-f(k),d(k+1)-d(k),0,'r','LineWidth',1)
                end
            end
        end        
    end    
end

clear all

%--------------------------------------------
%plotting human and lena labelled data spaces - child responses

load('humanlab_addat.mat')
load('chresp_zkm_match.mat')

for i = 1:length(age_adhumlab) %concatenates age, id and listener id
    id_age{i} =  sprintf('%s_%d_%s',childid_ad{i},age_adhumlab(i),listenerid_ad{i});
end

id_age = unique(id_age); % finds unique combinations

for i = 1:length(id_age)
    figure(i + 4);
    set(gcf,'color','w','PaperType','<custom>','PaperSize',[49 23.7]); %one figure for one listener and child-age combo
    axes1 = axes('Position',...
    [0.13 0.198412698412698 0.334659090909091 0.674999999999999]); %human label plot in one subplot
set(axes1,'FontSize',30);
    set(gcf,'color','w');
    hold all
    title(id_age{i},'Position',[-1.9675,2.0502 -1.4211e-14])
    ylabel('\bf{Amplitude}','Position',[-3.267597568559828 -0.514365431906163 -1.000000000000014])
    xlabel('\bf{Pitch}','Position',[5.005462682594946 -3.563173359451517 -1])
    for j =1:length(age_adhumlab)
        catmat = sprintf('%s_%d_%s',childid_ad{j},age_adhumlab(j),listenerid_ad{j});  %concatenates age, id, and listener id
        if strcmp(catmat,id_age{i}) == 1 %matches the unique id combos to each individual combo - so all of one kind, say, 183_82_edith, is plotted together
            f = adlogf_humlab{j};
            d = addb_humlab{j};
            r = chresp2ad_humlab{j};
            
            for k = 1:length(r)-1
                if r(k) == 1 %with response - if k receives a response, them k to k+1 is magenta, human
                    quiver(f(k),d(k),f(k+1)-f(k),d(k+1)-d(k),0,'Color',[1 0 1],'LineWidth',1)
                elseif r(k) == 0 %without, human, grey
                    quiver(f(k),d(k),f(k+1)-f(k),d(k+1)-d(k),0,'Color',[.7 .7 .7],'LineWidth',1)
                end
            end
        end        
    end    
end

for i = 1:length(id_age)
    figure(i + 4);
    axes2 = axes('Position',...
    [0.570340909090909 0.19973544973545 0.334659090909091 0.673677248677248]); %LENA label in other sub plot
set(axes2,'FontSize',30);
    hold all
    title('chresponse')
    for j =1:length(chr2ad_age)
        catmat = sprintf('%s_%d',chr2ad_id{j},chr2ad_age(j)); %concatenates id and age for lena labelled
        humspl = strsplit(id_age{i},'_');
        humcat = sprintf('%s_%s',humspl{1},humspl{2}); %picks out id and age from unique id_age combos for human labelled
        if strcmp(catmat,humcat) == 1 %matches with LENA - so '350_92' from lena and human are plotted side by side
            f = chr2ad_zlogf{j};
            d = chr2ad_zd{j};
            r = chr2ad{j};
            
            for k = 1:length(r)-1
                if r(k) == 1 %with response, lena
                    quiver(f(k),d(k),f(k+1)-f(k),d(k+1)-d(k),0,'k','LineWidth',1)
                elseif r(k) == 0 %without response, lena
                    quiver(f(k),d(k),f(k+1)-f(k),d(k+1)-d(k),0,'g','LineWidth',1)
                end
            end
        end        
    end    
end

%%
%--------------------------------------------
%plotting correlation - human labelled and corresponding lena labelled
for sec = 1
 
   clear all
   figure;
   
   %lch vocalisations - hum and lena label
   subplot(4,2,[1 3])
   hold all
   l_ch = readtable('chvoc_corrltn_mean.csv');
   h_ch = readtable('chvoc_corrltn_mean_hum.csv');
   
   plot(h_ch.age(h_ch.corrpval_ch < 0.05),h_ch.corrltn_ch(h_ch.corrpval_ch < 0.05),'ks','MarkerSize',15) 
   plot(h_ch.age(h_ch.corrpval_ch > 0.05),h_ch.corrltn_ch(h_ch.corrpval_ch > 0.05),'kx','MarkerSize',15)
   
   for i = 1:length(h_ch.age) %matching lena values
      for j = 1:length(l_ch.age)
       if (h_ch.age(i) == l_ch.age(j)) && (strcmp(num2str(h_ch.id(i)),l_ch.id(j)) == 1) 
           if l_ch.corrpval_ch(j) < 0.05
            plot(l_ch.age(j),l_ch.corrltn_ch(j),'rs','MarkerSize',15) %significant
           elseif l_ch.corrpval_ch(j) > 0.05
            plot(l_ch.age(j),l_ch.corrltn_ch(j),'rx','MarkerSize',15) %not significant
           end
       end
      end
   end
    
   plot(0:200,zeros(size(0:200)),'--') %0 line
   ylabel('\bf{Corr. Coeff.}','FontSize',30)
   xlabel('\bf{Infant age (days)}','FontSize',30)
   x = [0 200]; %fill area that is max and min of lena values
   y = [max(l_ch.corrltn_ch) max(l_ch.corrltn_ch)];
   plot(x,y,'m')
   x = [0 200]; %fill area that is max and min of lena values
   y = [min(l_ch.corrltn_ch) min(l_ch.corrltn_ch)];
   plot(x,y,'m')
   set(gcf,'color','w');
   title('\bf{(a chvocoverall)}')
  
   
   %adult vocalisations - hum and lena label
   clear all
   l_ad = readtable('advoc_corrltn_mean.csv');
   h_ad = readtable('advoc_corrltn_mean_hum.csv');
   
   subplot(4,2,[5 7])
   hold all
   
   plot(h_ad.age(h_ad.corrpval_ad < 0.05),h_ad.corrltn_ad(h_ad.corrpval_ad < 0.05),'ks','MarkerSize',15) %all are significant
   plot(h_ad.age(h_ad.corrpval_ad > 0.05),h_ad.corrltn_ad(h_ad.corrpval_ad > 0.05),'kx','MarkerSize',15)
   
   for i = 1:length(h_ad.age) %matching lena values
      for j = 1:length(l_ad.age)
       if (h_ad.age(i) == l_ad.age(j)) && (strcmp(num2str(h_ad.id(i)),l_ad.id(j)) == 1) 
           if l_ad.corrpval_ad(j) < 0.05  
            plot(l_ad.age(j),l_ad.corrltn_ad(j),'rs','MarkerSize',15) %significant
           end
       end
      end
   end
   
   for i = 1:length(h_ad.age) %matching lena values
      for j = 1:length(l_ad.age)
       if (h_ad.age(i) == l_ad.age(j)) && (strcmp(num2str(h_ad.id(i)),l_ad.id(j)) == 1) 
           l_ad.corrpval_ad(j)
           if l_ad.corrpval_ad(j) > 0.05  
            plot(l_ad.age(j),l_ad.corrltn_ad(j),'rx','MarkerSize',15) %significant
           end
       end
      end
   end
    
   plot(0:200,zeros(size(0:200)),'--') %0 line
   x = [0 200]; %fill area that is max and min of lena values
   y = [max(l_ad.corrltn_ad) max(l_ad.corrltn_ad)];
   plot(x,y,'m')
   x = [0 200]; %fill area that is max and min of lena values
   y = [min(l_ad.corrltn_ad) min(l_ad.corrltn_ad)];
   plot(x,y,'m')
   set(gcf,'color','w');
   title('\bf{(d advocoverall)}')
   ll = legend({'\bf{p < 0.05, HUM}','\bf{p > 0.05, HUM}','\bf{p < 0.05, LENA}','\bf{p > 0.05, LENA}'});
   %note that the legend for LENA p value greater than and less than 0.05
   %here only works because there is only one LENA p value 
   %lesser than 0.05, so even though the LENA points are plotted
   %individually, the sequence of the legend works out.
   set(ll,'Interpreter','tex');
    
end

%%
%--------------------------------------------

%plotting range, mean, etc, with human labelled data
clear all

for sec = 1
h_ch = readtable('chvoc_corrltn_mean_hum.csv');
l_ch = readtable('chvoc_corrltn_mean.csv');
h_ad = readtable('advoc_corrltn_mean_hum.csv');
l_ad = readtable('advoc_corrltn_mean.csv');

figure;
set(gcf,'color','w');
%child frequency
subplot(2,2,1) 
hold all
ylabel('\bf{Pitch}')
title('CH')

plot(l_ch.age(1),l_ch.mean_f_ch(1),'b-','lineWidth',2)
plot(l_ch.age(1),l_ch.mean_f_ch(1),'c-','lineWidth',2)

errorbar(l_ch.age,l_ch.mean_f_ch,l_ch.std_f_ch,'rs','MarkerSize',15)

for i = 1:length(h_ch.age) %matching lena values
  for j = 1:length(l_ch.age)
   if (h_ch.age(i) == l_ch.age(j)) && (strcmp(num2str(h_ch.id(i)),l_ch.id(j)) == 1) 
        errorbar(l_ch.age(j),l_ch.mean_f_ch(j),l_ch.std_f_ch(j),'cs','MarkerSize',15,'lineWidth',2);
   end     
  end
end

errorbar(h_ch.age,h_ch.mean_f_ch,h_ch.std_f_ch,'bs','MarkerSize',15,'lineWidth',2); %human labelled values

ll = legend({'\bf{HUM}','\bf{LENA}'});

%adult frequency
subplot(2,2,2) 
hold all
title('AD')

errorbar(l_ad.age,l_ad.mean_f_ad,l_ad.std_f_ad,'rs','MarkerSize',15)

for i = 1:length(h_ad.age) %matching lena values
  for j = 1:length(l_ad.age)
   if (h_ad.age(i) == l_ad.age(j)) && (strcmp(num2str(h_ad.id(i)),l_ad.id(j)) == 1) 
        errorbar(l_ad.age(j),l_ad.mean_f_ad(j),l_ad.std_f_ad(j),'cs','MarkerSize',15,'lineWidth',2);
    end     
  end
end

errorbar(h_ad.age,h_ad.mean_f_ad,h_ad.std_f_ad,'bs','MarkerSize',15,'lineWidth',2); %human labelled values

%child amplitude
subplot(2,2,3) 
hold all
xlabel('Infant age (days)')
ylabel('Amplitude')
title('CH')

errorbar(l_ch.age,l_ch.mean_d_ch,l_ch.std_d_ch,'rs','MarkerSize',15)

for i = 1:length(h_ch.age) %matching lena values
  for j = 1:length(l_ch.age)
   if (h_ch.age(i) == l_ch.age(j)) && (strcmp(num2str(h_ch.id(i)),l_ch.id(j)) == 1) 
        errorbar(l_ch.age(j),l_ch.mean_d_ch(j),l_ch.std_d_ch(j),'cs','MarkerSize',15,'lineWidth',2);
   end     
  end
end

errorbar(h_ch.age,h_ch.mean_d_ch,h_ch.std_d_ch,'bs','MarkerSize',15,'lineWidth',2); %human labelled values

%adult amplitude
subplot(2,2,4) 
hold all
title('AD')

errorbar(l_ad.age,l_ad.mean_d_ad,l_ad.std_d_ad,'rs','MarkerSize',15)

for i = 1:length(h_ad.age) %matching lena values
  for j = 1:length(l_ad.age)
   if (h_ad.age(i) == l_ad.age(j)) && (strcmp(num2str(h_ad.id(i)),l_ad.id(j)) == 1) 
        errorbar(l_ad.age(j),l_ad.mean_d_ad(j),l_ad.std_d_ad(j),'cs','MarkerSize',15,'lineWidth',2);
   end     
  end
end

errorbar(h_ad.age,h_ad.mean_d_ad,h_ad.std_d_ad,'bs','MarkerSize',15,'lineWidth',2); %human labelled values
end

