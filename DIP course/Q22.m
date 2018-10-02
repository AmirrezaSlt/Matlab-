close all
clear all

water = imread('1832897_orig.png');
water = rgb2gray(water);
water = imresize(water,0.16);
figure, imshow(water), title('gray-scale water molecule');
water = double(water);

%Normalize image
water = (water - min(min(water))) / (max(max(water)) - min(min(water)));

%Error Diffusion Dithering of molecule water
T = 0.5; %Threshold for Error Diffusion
water_hat = water;
water_binary = water_hat >= T;
e = water_binary - water_hat;
[M,N] = size(water);
for m = 2:(M-1)
    for n = 2:(N-1)
        water_binary(m,n) = water_hat(m,n) >= T;
        e(m,n) = water_binary(m,n) - water_hat(m,n);
        water_hat(m-1,n+1) = water_hat(m-1,n+1) - (e(m,n)*3/16);
        water_hat(m,n+1) = water_hat(m,n+1) - (e(m,n)*5/16);
        water_hat(m+1,n+1) = water_hat(m+1,n+1) - (e(m,n)*1/16);
        water_hat(m+1,n) = water_hat(m+1,n) - (e(m,n)*7/16);
    end
end
figure, imshow(water_binary),title('Error Diffusion Dithering');

%read cover image
baby = imread('1832897_orig.png');
baby = rgb2gray(baby);

%Padding Image to be dividible by 8
[M,N] = size(baby);
for m = 1:(8-mod(M,8))
    for n = 1:(8-mod(N,8))
        baby(M+m,n+N) = 0;
    end
end
figure, imshow(baby), title('Cover image without Steganography');
baby = double(baby);

%caclulate 2D DCT
%Create DCT Matrix
for n = 0:7
    for v = 0:7
        dct_v(n+1,v+1) = cos(pi*v*(2*n+1)/(2*8));
    end
end

for m = 0:7
    for u = 0:7
        dct_u(u+1,m+1) = cos(pi*u*(2*m+1)/(2*8));
    end
end

%Select 8*8 pieces of image and calculating DCT
[M,N] = size(baby);
[M_prime,N_prime] = size(water_binary);
for m = 0:(M/8 - 1)
    for n = 0:(N/8 - 1)
        window = baby((8*m+1):(8*m+8) , (8*n+1):(8*n+8));
        DCT = dct_u * (window * dct_v);
        %steganography
        if (m+1 <= M_prime) && (n+1 <= N_prime)
            if (water_binary(m+1,n+1) == 1) && (DCT(2,4) < DCT(3,1))
                r = DCT(2,4);
                DCT(2,4) = DCT(3,1);
                DCT(3,1) = r;
            elseif (water_binary(m+1,n+1) == 0) && (DCT(2,4) > DCT(3,1))
                r = DCT(2,4);
                DCT(2,4) = DCT(3,1);
                DCT(3,1) = r;
            end
        end
        %Reverse DCT
        window = inv(dct_u) * DCT * inv(dct_v);
        baby_stegano((8*m+1):(8*m+8) , (8*n+1):(8*n+8)) = window;
    end
end
figure, imshow(uint8(baby_stegano)), title('Cover image with steganography');

%Findout Message in cover
[M,N] = size(baby_stegano);
for m = 0:(M/8 - 1)
    for n = 0:(N/8 - 1)
        window = baby_stegano((8*m+1):(8*m+8) , (8*n+1):(8*n+8));
        DCT = dct_u * (window * dct_v);
        %steganography
        if (m+1 <= M_prime) && (n+1 <= N_prime)
            if (DCT(2,4) > DCT(3,1))
                message(m+1,n+1) = 1;
            elseif (DCT(2,4) < DCT(3,1))
                message(m+1,n+1) = 0;
            end
        end
    end
end
figure, imshow(message), title('Message achive from cover');