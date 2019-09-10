function confmat = makeconfmat(trueclass,predclass)

confmat = zeros(max(trueclass));

for i=1:length(trueclass)
    confmat(trueclass(i),predclass(i)) = confmat(trueclass(i),predclass(i)) + 1;
end
