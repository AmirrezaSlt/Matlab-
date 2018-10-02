function z=euclidean_classifier(m,X)
[~,c]=size(m); % l=dimensionality, c=no. of classes
[~,N]=size(X); % N=no. of vectors
for i=1:N
    for j=1:c
        t(j)=sqrt((X(:,i)-m(:,j))'*(X(:,i)-m(:,j)));
    end
    % Determining the maximum quantity Pi*p(x|wi)
    [~,z(i)]=min(t);
end