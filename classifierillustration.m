function [cmat,meanacc,stdacc]=classifierillustration(file,ncross,ntrials)

% initialize the random number generator to a known value
rand('twister',666);

% read the data matrix from a Comma Separated Value (csv) file
datamatrix = csvread(file);

% the data matrix has the class label in the first column
% copy it into a separate vector
y = datamatrix(:,1);
% make sure that the class labels start from 1
y = y - min(y) + 1;

% copy the rest of the data matrix (just the features)
x = datamatrix(:,2:end);

[cmat,meanacc,stdacc]=crossvalclassifier(x,y,ncross,ntrials);
