clear all
close all
%Create chessboard image
a = ones(30,300);
for k = 1:10
    d = mod(k,2);
    f(30*(k-1) + 1 : 30*k , :) = d*a; 
end
f = xor(f , f');
fig1 = figure; imshow(f), title('Original Image');

%Warping
[M,N] = size(f);
theta = pi/3;
j = 0;
for m = 1:M
    for n = 1:N
        x = round(10 + cos(theta)*m + sin(theta)*n + 0.002*m*n);
        y = round(6 - sin(theta)*m + cos(theta)*n + 0.004*m*n);
        if x>0 && y>0
            f_warped(x,y) = f(m,n);
        end
    end
end
[X,Y] = size(f_warped);
disp(['size of warped image is = [' ,num2str(X),' , ',num2str(Y),']' ]);
fig2 = figure; imshow(f_warped), title('Warped Image');

n = 8;
figure(fig1);
[v,u] = ginput(n);
figure(fig2);
[y,x] = ginput(n);

U = [u, v, u.*v, ones(n,1)];
X = [x, y, ones(n,1)];
A = inv(U'*U) * U' * X;
disp('Coefficient Matrix is:');
disp(A);
