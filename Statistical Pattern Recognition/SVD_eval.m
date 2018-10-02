function [s,Ur,w,w0,distX,distX_proj]=SVD_eval(X,k)
[l,~]=size(X);
[Ur,S,Vr] = svd(X);
s=diag(S(1:l,1:l));
a=S(1:k,1:k)*Vr(:,1:k)';
X_proj=Ur(:,1:k)*a;
% Deterimnation of the estimated by the SVD hypeprlane
P=X_proj(:,1:l)';
w=[];
for i=1:l
    w=[w (-1)^(i+1)*det([P(:,1:i-1) P(:,i+1:l) ones(l,1)])];
end
w0=(-1)^(l+2)*det(P(:,1:l));
% Computation of distances
distX=compute_distances(X);
distX_proj=compute_distances(X_proj);