function z=bayes_classifier(m,S,P,X)
[~,c]=size(m); % l=dimensionality, c=no. of classes
[~,N]=size(X); % N=no. of vectors
for i=1:N
    for j=1:c
        t(j)=P(j)*comp_gauss_dens_val(m(:,j),S(:,:,j),X(:,i));
    end
    % Determining the maximum quantity Pi*p(x|wi)
    [~,z(i)]=max(t);
end