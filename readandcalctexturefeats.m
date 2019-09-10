function [filenames,feats] = readandcalctexturefeats(path,channel)
% calculate four texture features for all files matching path, using a
% specified channel if given (otherwise use channel 1)

% assume channel 1 if no specification given
if nargin<2
    channel = 1;
end

% calculate features for all four directions of adjacency
offsets = [0 1;-1 1;-1 0;-1 -1];
NumLevels = 128;

feats = [];
dirls=dir(path);
for i=1:length(dirls)
    filenames{i}=dirls(i).name;
    img=imread(filenames{i});
    % setting GrayLimits to [] causes full contrast stretching
    GLCMS = graycomatrix(img(:,:,channel),'Offset',offsets,'NumLevels',NumLevels,'GrayLimits',[]); 
    stats = graycoprops(GLCMS,'all');
    % average features over all four directions
    feats(i,1) = mean(stats.Contrast);
    feats(i,2) = mean(stats.Correlation);
    feats(i,3) = mean(stats.Energy);
    feats(i,4) = mean(stats.Homogeneity);
end
