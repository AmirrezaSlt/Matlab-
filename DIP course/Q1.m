close all
clear all
%Create Ordered Dither Matrix
I2 = [0 2 ; 3 1];
I4 = [4*I2+1 , 4*I2+2 ; 4*I2+3 , 4*I2];
I8 = [4*I4+1 , 4*I4+2 ; 4*I4+3 , 4*I4];
I2 = I2 /(max(max(I2))+1);
I4 = I4 /(max(max(I4))+1);
I8 = I8 /(max(max(I8))+1);

%Create Desired image
for m = 1:250
    for n = 1:250
        r = sqrt((m - 125)^2 + (n - 125)^2);
        f(m,n) = mod(r,50);
    end
end
figure, imshow(uint8(f)), title('Original Gray-Scale image');

%Padding Image to be dividible by 8
[M,N] = size(f);
for m = 1:(8-mod(M,8))
    for n = 1:(8-mod(N,8))
        f(M+m,n+N) = 0;
    end
end

%Normalize image
f = (f - min(min(f))) / (max(max(f)) - min(min(f)));

%Half-toning with I2, I4, I8
g_2 = f;
[M,N] = size(f);
for m = 0:fix(M/2)-1
    for n = 0:fix(N/2)-1
        g_2(2*m+1:2*m+2 , 2*n+1:2*n+2) = f(2*m+1:2*m+2 , 2*n+1:2*n+2) >= I2;
    end
end
figure; imshow(g_2); title('Ordered Dithering Image with I2 and D=[0 2;3 1]');

g_4 = f;
[M,N] = size(f);
for m = 0:fix(M/4)-1
    for n = 0:fix(N/4)-1
        g_4(4*m+1:4*m+4 , 4*n+1:4*n+4) = f(4*m+1:4*m+4 , 4*n+1:4*n+4) >= I4;
    end
end
figure; imshow(g_4); title('Ordered Dithering Image with I4 and D=[0 2;3 1]');

g_8 = f;
[M,N] = size(f);
for m = 0:fix(M/8)-1
    for n = 0:fix(N/8)-1
        g_8(8*m+1:8*m+8 , 8*n+1:8*n+8) = f(8*m+1:8*m+8 , 8*n+1:8*n+8) >= I8;
    end
end
figure; imshow(g_8); title('Ordered Dithering Image with I8 and D=[0 2;3 1]');

%Change Ordered Dither Matrix and Repeat above
I2 = [1 0 ; 1 1];
I4 = [4*I2+1 , 4*I2+2 ; 4*I2+3 , 4*I2];
I8 = [4*I4+1 , 4*I4+2 ; 4*I4+3 , 4*I4];
I2 = I2 /(max(max(I2))+1);
I4 = I4 /(max(max(I4))+1);
I8 = I8 /(max(max(I8))+1);
disp(I8);
y_2 = f;
[M,N] = size(f);
for m = 0:fix(M/2)-1
    for n = 0:fix(N/2)-1
        y_2(2*m+1:2*m+2 , 2*n+1:2*n+2) = f(2*m+1:2*m+2 , 2*n+1:2*n+2) >= I2;
    end
end
figure; imshow(y_2); title('Ordered Dithering Image with I2 and D=[1 0;1 1]');

y_4 = f;
[M,N] = size(f);
for m = 0:fix(M/4)-1
    for n = 0:fix(N/4)-1
        y_4(4*m+1:4*m+4 , 4*n+1:4*n+4) = f(4*m+1:4*m+4 , 4*n+1:4*n+4) >= I4;
    end
end
figure; imshow(y_4); title('Ordered Dithering Image with I4 and D=[1 0;1 1]');

y_8 = f;
[M,N] = size(f);
for m = 0:fix(M/8)-1
    for n = 0:fix(N/8)-1
        y_8(8*m+1:8*m+8 , 8*n+1:8*n+8) = f(8*m+1:8*m+8 , 8*n+1:8*n+8) >= I8;
    end
end
figure; imshow(y_8); title('Ordered Dithering Image with I8 and D=[1 0;1 1]');

%Error Diffusion Half-toning
T = 0.5; %Threshold for Error Diffusion
f_hat = f;
b = f_hat >= T;
e = b - f_hat;
[M,N] = size(f);
for m = 2:(M-1)
    for n = 2:(N-1)
        b(m,n) = f_hat(m,n) >= T;
        e(m,n) = b(m,n) - f_hat(m,n);
        f_hat(m-1,n+1) = f_hat(m-1,n+1) - (e(m,n)*3/16);
        f_hat(m,n+1) = f_hat(m,n+1) - (e(m,n)*5/16);
        f_hat(m+1,n+1) = f_hat(m+1,n+1) - (e(m,n)*1/16);
        f_hat(m+1,n) = f_hat(m+1,n) - (e(m,n)*7/16);
    end
end
figure, imshow(b),title('Error Diffusion Dithering');

%Dot Diffusion Half-toning
T = 0.5; %Threshold for Dot Diffusion
g = f;
C = [59 12 46 60 28 14 32 3;  %Class Matrix for Dot Diffusion
    21 25 44 11 58 45 43 30;
    24 20 13 42 33 5 54 8;
    64 52 55 40 63 47 7 18;
    35 57 9 15 50 48 4 36;
    41 17 6 61 22 49 62 34;
    2 53 19 56 39 23 26 51;
    16 37 1 31 29 27 38 10];
C_hat = zeros(10);
C_hat(2:9 , 2:9) = C;
%Create Wieght Matrix for each element in Class Matrix out of main loop for
%reduce process time
for i = 1:64
    mask(:,:,i) = double(C_hat(fix((i-1)/8)+1 : fix((i-1)/8)+3 , mod(i-1,8)+1 : mod(i-1,8)+3) > C_hat(fix((i-1)/8)+2 , mod(i-1,8)+2));
    mask(:,:,i) = mask(:,:,i) .* [1 2 1 ; 2 2 2 ; 1 2 1];
    if sum(sum(mask(:,:,i)))
        mask(:,:,i) = mask(:,:,i) / sum(sum(mask(:,:,i)));
    end
end
%Order Matrix tell us process order for each element in 8*8 Matrix
for i = 1:64
    order(i) = find(C == i);
end
%start of Dot Diffusion
[M,N] = size(f);
for m = 0:fix(M/8)-1
    for n = 0:fix(N/8)-1
        for i = 1:64
            g(8*m+1 + fix((order(i)-1)/8), 8*n+1 + mod(order(i)-1,8)) = f(8*m+1 + fix((order(i)-1)/8), 8*n+1 + mod(order(i)-1,8)) >= T;
            e = f(8*m+1 + fix((order(i)-1)/8), 8*n+1 + mod(order(i)-1,8)) - g(8*m+1 + fix((order(i)-1)/8), 8*n+1 + mod(order(i)-1,8));
            h = e * mask(:,:,i);
            if ((8*m+1 + fix((order(i)-1)/8)) ~= 1) && ((8*m+1 + fix((order(i)-1)/8)) ~= M)
                if (8*n+1 + mod(order(i)-1,8) ~= 1) && (8*n+1 + mod(order(i)-1,8) ~= N)
                    f(8*m + fix((order(i)-1)/8) : 8*m+2 + fix((order(i)-1)/8), 8*n + mod(order(i)-1,8) : 8*n+2 + mod(order(i)-1,8)) = f(8*m + fix((order(i)-1)/8) : 8*m+2 + fix((order(i)-1)/8), 8*n + mod(order(i)-1,8) : 8*n+2 + mod(order(i)-1,8)) + h;
                end
            end
         end
    end
end
figure, imshow(g), title('Dot Diffusion');

            

