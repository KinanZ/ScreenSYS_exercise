function [Xtrain,ytrain,Xtest,ytest]=dividefolds(X,y,rndind,ncross,icross)

[npoints,nvar]=size(X);
npoints2=length(y);
if(npoints~=npoints2) error('dimensions of X and y must match.'); end

ifold=floor(npoints/ncross);

if(icross<=1)
    testind = [1:ifold];
    trainind= [(ifold+1):npoints];
else if(icross>=ncross)
	testind = [((ncross-1)*ifold+1):npoints];
	trainind = [1:((ncross-1)*ifold)];
else
	testind = [((icross-1)*ifold+1):(icross*ifold)];
	trainind = [1:((icross-1)*ifold) (icross*ifold+1):npoints];
end
end
     Xtest=X(rndind(testind),:);
     ytest=y(rndind(testind));

     Xtrain=X(rndind(trainind),:);
     ytrain=y(rndind(trainind));
