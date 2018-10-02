function distX=compute_distances(X)
[~,N]=size(X);
distX=zeros(N);
for i=1:N
    for j=i+1:N
        distX(i,j)=(X(:,i)-X(:,j))'*(X(:,i)-X(:,j));
        distX(j,i)=distX(i,j);
    end
end