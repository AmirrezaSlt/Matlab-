function clas_error=compute_error(y,y_est)
N=length(y);
nc=length(find(y==y_est));
ne=N-nc;
clas_error=ne/N;
end