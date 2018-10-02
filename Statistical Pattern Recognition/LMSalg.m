function w=LMSalg(X,y,w_ini)
[~,N]=size(X);
rho=0.1; % Learning rate initialization
w=w_ini; % Initialization of the parameter vector
for i=1:N
    w=w+(rho/i)*(y(i)-X(:,i)'*w)*X(:,i);
end
end