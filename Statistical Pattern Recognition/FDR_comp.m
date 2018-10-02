function FDR=FDR_comp(X,y,ind)
c=max(y);
for i=1:c
y_temp=(y==i);
X_temp=X(ind,y_temp);
m(i)=mean(X_temp);
vari(i)=var(X_temp);
end
a=nchoosek(1:c,2);
q=(m(a(:,1))-m(a(:,2))).^ 2 ./ (vari(a(:,1))+vari(a(:,2)))';
FDR=sum(q);
end