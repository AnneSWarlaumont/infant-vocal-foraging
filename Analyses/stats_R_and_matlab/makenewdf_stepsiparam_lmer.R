#Ritwika VPS, UC Merced
#function to generate dataframe with only best fit type parameters
#for eg, if we were doing lmer stats for step size distributions in frequency dimension, then only distributions best fit to an exponential would be considered

makenewdf_stepsiparam_lmer <- function(mydata,dpdtvar,dpdtvar_index) { #we make a new data frame to perform analyses on (for step size distance parameters). Depending on which dependent variable we are analyzing
	#(input dpdtvar), we filter based on which distributions are best fit to the majority fit type distribution. dpdtvar_index is used to pick out the dependent variable from the filtered dataframe
	
	name_of_dpdt = colnames(dpdtvar) #get name of dependent variable
	
	if (grepl("d",name_of_dpdt) == 1){ #check if dependent variable is amplitude parameter - contains d (expd)
		
		filter_col = mydata$d_fit #the vector to use for filtering
		
		#find mode of fit values
		uniqv <- unique(filter_col)
	    mode_fit = uniqv[which.max(tabulate(match(filter_col, uniqv)))]
	    
	    mydata_filter = mydata[mydata$d_fit == mode_fit,] #filter mydata based on majority fit type for the dependent variable of interest
	   
	}else if (grepl("f",name_of_dpdt) == 1){#for expf - frequency parameters
		
		filter_col = mydata$f_fit #the vector to use for filtering
		
		#find mode of fit values
		uniqv <- unique(filter_col)
	    mode_fit = uniqv[which.max(tabulate(match(filter_col, uniqv)))]
	    
	    mydata_filter = mydata[mydata$f_fit == mode_fit,] #filter mydata based on majority fit type for the dependent variable of interest
	
	}else if (grepl("sp",name_of_dpdt) == 1) { #for space fits
		
		filter_col = mydata$sp_fit #the vector to use for filtering
		
		#find mode of fit values
		uniqv <- unique(filter_col)
	    mode_fit = uniqv[which.max(tabulate(match(filter_col, uniqv)))]
	    
	    mydata_filter = mydata[mydata$sp_fit == mode_fit,] #filter mydata based on majority fit type for the dependent variable of interest
		
	}else if (grepl("tim",name_of_dpdt) == 1) { #for time fits
		
		filter_col = mydata$tim_fit #the vector to use for filtering
		
		#find mode of fit values
		uniqv <- unique(filter_col)
	    mode_fit = uniqv[which.max(tabulate(match(filter_col, uniqv)))]
	    
	    mydata_filter = mydata[mydata$tim_fit == mode_fit,] #filter mydata based on majority fit type for the dependent variable of interest	
	
	}	
	  
	dpdtvar_filter = mydata_filter[dpdtvar_index] #picks out filtered dpdt variable from the new dataframe so we can save only that
	#doing mydata_filter[single index] helps us preserve the column vector instead of recasting it as an unnamed row
	id_filter = mydata_filter[1] #picks out id
	age_filter = mydata_filter[2]   #age
	smplsize_filter = mydata_filter[9]  #samplesize
	response_filter = mydata_filter[10] #response
	  
	newdf = data.frame(dpdtvar_filter,id_filter,age_filter,smplsize_filter,response_filter) #create new dataframe with only variables required for analyses
		
}

