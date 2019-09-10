%run “classifierillustration” on the csv file.  
%Do 10 cross-validation folds and 1 trial.  
%The script will display a confusion matrix showing 
%the number of images from each true class that was classified in each predicted class.

file = "imagefeatures.csv";
ncross = 10;
ntrials = 1;

[cmat,meanacc,stdacc] = classifierillustration(file,ncross,ntrials);

% a. Which class is recognized with the highest accuracy (give the class number)?
% accuracy = TP/TP+FP
% TP for each class is the diagonal value
% FP for a class is the sum of the values in the corresponding column (excluding the TF)

TP = diag(cmat);
FP = sum(cmat,1).' - TP;
prec = TP./(TP+FP);

[class_prec, class_with_highest_prec] = max(prec);

% b.	What is the overall accuracy of the classifier 
%(the percentage of images that it classifies correctly)?

overall_p = mean(prec)*100;

TP = diag(cmat);
FP = sum(cmat,1).' - TP;
FN = sum(cmat,2) - TP;
for i = 1:size(cmat,1)
    TN(i) = sum(cmat(:))-FN(i)-FP(i)-TP(i);
end

accuracy = (TP+TN.')./(TP+FP+TN.'+FN);

[class_accuracy, class_with_highest_accuracy] = max(accuracy);

% b.	What is the overall accuracy of the classifier 
%(the percentage of images that it classifies correctly)?

overall_accuracy = mean(accuracy)*100;

% c.	Which two classes are most confused with each other (give the class numbers)?
% I will calculate the confusion between each two classes

confused_couple = zeros(10);
for i=1:10
    for j=1:10
        if i~=j
            confused_couple(i,j)= cmat(i,j)+cmat(j,i);
        end
    end
end
most_confused_couple_indx = find(confused_couple == max(confused_couple(:)));
[most_confused_couple_row,most_confused_couple_col] = ind2sub(size(confused_couple),most_confused_couple_indx(1));

% d.	What do you expect the overall accuracy to be if you merged 
% the two most-confused classes into one class?

mergeConfusedClasses(file, most_confused_couple_row, most_confused_couple_col);

% new accuracy
new_file = "imagefeatures_merged.csv";
[new_cmat,new_meanacc,new_stdacc] = classifierillustration(new_file,ncross,ntrials);
TP = diag(new_cmat);
FP = sum(new_cmat,1).' - TP;
new_accuracy = TP./(TP+FP);
new_overall_accuracy = mean(new_accuracy)*100;

