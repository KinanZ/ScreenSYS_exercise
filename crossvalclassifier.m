function [cmat,meanacc,stdacc]=crossvallclassifier(x,y,ncross,ntrials)

% initialize the random number generator to a known value
rand('twister',666);

% initialize the combined confusion matrix (for all trials) to zeros
combconf = zeros(max(y));

for i=1:ntrials
    
    [confmat,accuracy]=trainandtest(x,y,ncross);
% add the values for the new confusion matrix to the previous ones
    combconf=combconf + confmat;
% remember the accuracy for this trial
    acc(i) = accuracy;
end

% print out the confusion matrix, mean accuracy and std. deviation
cmat = round(combconf./ntrials,2);
meanacc = mean(acc);
stdacc = std(acc);