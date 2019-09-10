function [confmat,accuracy]=trainandtest(x,y,ncross)

[npoints,nvar]=size(x);

% get a random ordering of the data points
rndind=randperm(npoints);

% initialize the truth and predictions vectors to empty so that they can be
% concatenated with the results of each fold
truth = [];
predictions = [];

for icross=1:ncross

    [Xtrain,ytrain,Xtest,ytest]=dividefolds(x,y,rndind,ncross,icross);

    predclass = classify(Xtest,Xtrain,ytrain);

    truth = [truth; ytest];
    predictions = [predictions; predclass];
    
end

confmat = makeconfmat(truth, predictions);

accuracy = sum(diag(confmat))/sum(sum(confmat));