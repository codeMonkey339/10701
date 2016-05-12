function [pred, model] = adaboost(trainX, trainY, testX, T)
model=struct;
% Weight of training samples, first every sample is even important
% (same weight)
D=ones(length(trainY),1)/length(trainY);
% This variable will contain the results of the single weak
% classifiers weight by their alpha
estimateclasssum=zeros(size(trainY));
% Calculate max min of the data
boundary=[min(trainX,[],1) max(trainX,[],1)];
% Do all model training itterations
for t=1:T
    % Find the best treshold to separate the data in two classes
    [estimateclass,err,h] = WeightedThresholdClassifier(trainX,trainY,D);

    % Weak classifier influence on total result is based on the current
    % classification error
    alpha=1/2 * log((1-err)/err);

    % Store the model parameters
    model(t).alpha = alpha;
    model(t).dimension=h.dimension;
    model(t).threshold=h.threshold;
    model(t).direction=h.direction;
    model(t).boundary = boundary;
    model(t).error_hi = (estimateclass~=trainY)'*D/length(trainY);
    
    % We update D so that wrongly classified samples will have more weight
    D = D.* exp(-model(t).alpha.*trainY.*estimateclass);
    D = D./sum(D);

    % Calculate the current error of the cascade of weak
    % classifiers
    estimateclasssum=estimateclasssum +estimateclass*model(t).alpha;
    pred=sign(estimateclasssum);
    model(t).pred = pred;
    model(t).error=sum(pred~=trainY)/length(trainY);
    Alpha = 0;
    margin = zeros(length(trainY), 1);
    for i = 1:t
        margin = margin + model(i).alpha*model(i).pred;
        Alpha = Alpha + model(i).alpha;
    end
    model(t).margin = (margin./Alpha).*trainY;
%     if(model(t).error==0)
%         break; 
%     end
end

%% testing
% Limit datafeatures to orgininal boundaries
if(length(model)>1);
    minb=model(1).boundary(1:end/2);
    maxb=model(1).boundary(end/2+1:end);
    testX=bsxfun(@min,testX,maxb);
    testX=bsxfun(@max,testX,minb);
end

% Add all results of the single weak classifiers weighted by their alpha 
estimateclasssum=zeros(size(testX,1),1);
for t=1:length(model);
    estimateclasssum=estimateclasssum+model(t).alpha*ApplyClassTreshold(model(t), testX);
end
% If the total sum of all weak classifiers
% is less than zero it is probablly class -1 otherwise class 1;
pred=sign(estimateclasssum);
end

function [estimateclass,err,h] = WeightedThresholdClassifier(trainX,trainY,D)
% This is an example of an "Weak Classifier", it caculates the optimal
% threshold for all data feature dimensions.
% It then selects the dimension and  treshold which divides the 
% data into two class with the smallest error.

% Number of treshold steps
ntre=2e5;

% Split the data in two classes 1 and -1
r1=trainX(trainY<0,:); 
w1=D(trainY<0);
r2=trainX(trainY>0,:); 
w2=D(trainY>0);

% Calculate the min and max for every dimensions
minr=min(trainX,[],1)-1e-10; 
maxr=max(trainX,[],1)+1e-10;

% Make a weighted histogram of the two classes
p2c= ceil((bsxfun(@rdivide,bsxfun(@minus,r2,minr),(maxr-minr)))*(ntre-1)+1+1e-9);   
p2c(p2c>ntre)=ntre;
p1f=floor((bsxfun(@rdivide,bsxfun(@minus,r1,minr),(maxr-minr)))*(ntre-1)+1-1e-9);  
p1f(p1f<1)=1;
ndims=size(trainX,2);
i1=repmat(1:ndims,size(p1f,1),1);  
i2=repmat(1:ndims,size(p2c,1),1);
h1f=accumarray([p1f(:) i1(:)],repmat(w1(:),ndims,1),[ntre ndims],[],0);
h2c=accumarray([p2c(:) i2(:)],repmat(w2(:),ndims,1),[ntre ndims],[],0);

% This function calculates the error for every all possible treshold value
% and dimension
h2ic=cumsum(h2c,1);
h1rf=cumsum(h1f(end:-1:1,:),1); 
h1rf=h1rf(end:-1:1,:);
e1a=h1rf+h2ic;
e2a=sum(D)-e1a;

% We want the treshold value and dimension with the minimum error
[err1a,ind1a]=min(e1a,[],1);  
dim1a=(1:ndims); 
dir1a=ones(1,ndims);
[err2a,ind2a]=min(e2a,[],1);  
dim2a=(1:ndims); 
dir2a=-ones(1,ndims);
A=[err1a(:),dim1a(:),dir1a(:),ind1a(:);err2a(:),dim2a(:),dir2a(:),ind2a(:)];
[err,i]=min(A(:,1)); dim=A(i,2); dir=A(i,3); ind=A(i,4);
thresholds = linspace(minr(dim),maxr(dim),ntre);
thr=thresholds(ind);

% Apply the new treshold
h.dimension = dim; 
h.threshold = thr; 
h.direction = dir;
estimateclass=ApplyClassTreshold(h,trainX);
end

function y = ApplyClassTreshold(h, x)
% Draw a line in one dimension (like horizontal or vertical)
% and classify everything below the line to one of the 2 classes
% and everything above the line to the other class.
if(h.direction == 1)
    y =  double(x(:,h.dimension) >= h.threshold);
else
    y =  double(x(:,h.dimension) < h.threshold);
end
y(y==0) = -1;
end