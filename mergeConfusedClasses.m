function [] = mergeConfusedClasses(file, most_confused_couple_1, most_confused_couple_2)
%merging the 2 most confused classes

% read the data matrix from a Comma Separated Value (csv) file
datamatrix = csvread(file);

row = find(datamatrix(:,1) == most_confused_couple_1);
datamatrix(row,1) = most_confused_couple_2;
datamatrix = sortrows(datamatrix);

row = find(datamatrix(:,1) == max(datamatrix(:,1)));
datamatrix(row,1) = max(datamatrix(:,1))-1;
csvwrite('imagefeatures_merged.csv',datamatrix);

end

