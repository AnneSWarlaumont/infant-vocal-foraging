%This function was written by Elliot Layden, 
%and downloaded from MATLAB file exchange: https://www.mathworks.com/matlabcentral/fileexchange/69943-simple-cohen-s-kappa
%Github link: https://github.com/elayden/cohensKappa

function kappa = cohensKappa(y, yhat)
    C = confusionmat(y, yhat); % compute confusion matrix
    n = sum(C(:)); % get total N
    C = C./n; % Convert confusion matrix counts to proportion of n
    r = sum(C,2); % row sum
    s = sum(C); % column sum
    expected = r*s; % expected proportion for random agree
    po = sum(diag(C)); % Observed proportion correct
    pe = sum(diag(expected)); % Proportion correct expected
    kappa = (po-pe)/(1-pe); % Cohen's kappa
end