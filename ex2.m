%Create a script to calculate the features from the six images of the first protein 
%and then the six images of the second proteins.  
%Generate a vector that has the class number (1 for the first protein, 2 for the second protein) 
%and then use “crossvalclassifier” six-fold cross-validation with 10 random trials for each fold.

% define paths
path1 = '*B5*.jpg';
path2 = '*A4*.jpg';
channel = 1;

% calculate the features from the six images of the first protein 
% and then the six images of the second proteins
[filenames1,feats1] = readandcalctexturefeats(path1,channel);
[filenames2,feats2] = readandcalctexturefeats(path2,channel);

% Generate a vector that has the class number (1 for the first protein, 2 for the second protein)
labels1 = ones(size(feats1,1),1);
labels2 = ones(size(feats2,1),1)*2;

% concat everything and export to csv
imagesFeatures = [labels1 feats1;labels2 feats2];
csvwrite('imagefeatures_green_cells.csv',imagesFeatures);

% use “crossvalclassifier” six-fold cross-validation with 10 random trials for each fold. 
file = 'imagefeatures_green_cells.csv';
ncross = 6;
ntrials = 10;
[cmat,meanacc,stdacc] = classifierillustration(file,ncross,ntrials);

%What fraction of the images was correctly classified?
%Given an unknown image of one of your proteins
%what are the chances your classifier will predict it correctly?
TP = diag(cmat);
FP = sum(cmat,1).' - TP;
accuracy = TP./(TP+FP);
overall_accuracy = mean(accuracy)*100;

%If an image contains your second protein,
%what is the chance the classifier actually predicts it is your first protein?
FP2 = sum(cmat(2,:)) - TP(2);