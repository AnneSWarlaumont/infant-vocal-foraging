%Ritwikam UC Merced
clear all
clc

%matching the d and f values for adult vocalisations based on child
%response data
%also picking out relevant points for adult response data

%generating_TimeSeries_data.m, generating_adultresponse2child_data.m, 
%generating_childresponse2adult_data.m have to be run before this
load('chrespdata_raw.mat')
load('addata_raw.mat')
load('data_zkm.mat')

%adult response data - we have to match speaker id, age, and subrecording
%to each other - here, we have to match child vocalisations that have
%received adult reponses or not to their f and d

countadr = 0;

for i  = 1:length(start_all)
    for j = 1:length(adstart)
        if (strcmp(id_adresp(j),id(i)) == 1) && (segm(i) == segm_adresp(j)) && (age_adresp(j) == age(i)) %match age, id and segment number
            
            countadr = countadr+1;
            
            if (isempty(start_all{i}) == 0) && (isempty(adstart{j}) == 0)
                
            allst = start_all{i};
            alld = z_dall{i};
            allen = end_all{i};
            allf = z_logfall{i};
            allk = km_all{i};
            
            adrst = adstart{j};
            adr = adresp{j};
            
            [ss,iadr,iall] = intersect(adrst,allst);
            
            adr_st{countadr} = allst(iall);
            adr_en{countadr} = allen(iall);
            adresponse{countadr} = adr(iadr);
            adr_zd{countadr} = alld(iall);
            adr_zlogf{countadr} = allf(iall);
            adr_km{countadr} = allk(iall);
            adr_age(countadr) = age(i);
            adr_id(countadr) = id(i);
            adr_segm(countadr) = segm(i);
            
            end
        end
    end
end

save('adresp_zkm_match.mat','adr_st','adr_en','adresponse','adr_zd','adr_zlogf','adr_km','adr_age','adr_id','adr_segm')
%child response data - we have to match speaker id, age, and subrecording
%to each other - matching adult vocalisations that have received child
%responses or not to corresponding f and d

countchr = 0;

for i  = 1:length(start_all)
    for j = 1:length(chrespst)
        if (strcmp(id_chresp(j),id(i)) == 1) && (segm(i) == segm_chresp(j)) && (age_chresp(j) == age(i))
            
            countchr = countchr+1;
            
            if (isempty(start_all{i}) == 0) && (isempty(chrespst{j}) == 0) %check that both entries are not empty
                
            allst = start_all{i};
            alld = z_dall{i};
            allen = end_all{i};
            allf = z_logfall{i};
            allk = km_all{i};
            
            chrst = chrespst{j};
            chr = chresp{j};
            
            [ss,ichr,iall] = intersect(chrst,allst);
            chr2ad_st{countchr} = allst(iall);
            chr2ad_en{countchr} = allen(iall);
            chr2ad{countchr} = chr(ichr);
            chr2ad_zd{countchr} = alld(iall);
            chr2ad_zlogf{countchr} = allf(iall);
            chr2ad_km{countchr} = allk(iall);
            chr2ad_age(countchr) = age(i);
            chr2ad_id(countchr) = id(i);
            chr2ad_segm(countchr) = segm(i);
            
            end
        end
    end
end

save('chresp_zkm_match.mat','chr2ad_st','chr2ad_en','chr2ad','chr2ad_zd','chr2ad_zlogf','chr2ad_km','chr2ad_age','chr2ad_id','chr2ad_segm')

    
