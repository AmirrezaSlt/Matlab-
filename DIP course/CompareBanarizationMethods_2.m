clc;
clear;
close all;
f=imread('bloodcells1.jpg');
f=rgb2gray(f);
[M,N]=size(f);
h_original = imhist(f);   
p = h_original./numel(f);  
figure (1); imshow(f,[]); title('Original image');
figure (2); plot(h_original);

%% for T=127
T = 127;
for m = 1:M
    for n = 1:N
        g(m,n) = f(m,n) >= T;
    end 
end
figure (3); imshow(g,[]); title('Global threshold T=127');

%% Adaptive Thereshold
T = 127 %initial
for iter = 1:50
    p1 = h_original(1:T+1,1)/sum(h_original(1:T+1,1));
    u1 = [0:T]*p1;
    p2 = h_original(T+2:256,1)/sum(h_original(T+2:256,1));
    u2 = [T+1:255]*p2;
    T_new(iter+1) = (u1+u2)/2;
%     if abs(T-T_new(iteration)) <= 1e-6
%         break 
%     end
    T = T_new(iter+1);
end

for m=1:M
    for n=1:N
        g1(m,n) = f(m,n) >= T;
    end 
end
T_new(1) = 127;
t1=1:51;
figure (5); imshow(g1); title(['Global Method - Addaptive T=',num2str(T)]);
figure (6); plot(t1,T_new,'-');
figure (7); plot(h_original);

%% OTSU Method - Global
tic
for T=1:254
    p1 = sum(p(1:T+1));
    p2 = sum(p(T+2:256));
    u1 = [0:T]*((h_original(1:T+1))/(sum(h_original(1:T+1))));
    u2 = [T+1:255]*((h_original(T+2:256))/(sum(h_original(T+2:256))));
    zigma1 = (([0:T]-u1).^2)*((h_original(1:T+1))/(sum(h_original(1:T+1))));
    zigma2 = (([T+1:255]-u2).^2)*((h_original(T+2:256))/(sum(h_original(T+2:256))));
    epsilon(T) = (zigma1*sum(p(1:T+1)))+(zigma2*sum(p(T+2:256)));
end 
OTSU = toc
T_new = find(epsilon == min(epsilon));
for m=1:M
    for n=1:N
        g2(m,n) = f(m,n) >= T_new;
    end 
end

figure (8); imshow(g2);
figure (9); plot(h_original);
figure (10); plot(epsilon);

%% Niblack Method - Local
w = 15;
k = 0.1;
f1 = padarray(f,[(w-1)/2 (w-1)/2],'symmetric','both');
for m=(1+(w-1)/2):M+2
    for n=(1+(w-1)/2):N+2
        window = f1(m-(w-1)/2:m+(w-1)/2,n-(w-1)/2:n+(w-1)/2);
        std_w = std2(window);
        mean_w = mean2(window);
        T(m-(w-1)/2,n-(w-1)/2) = mean_w-(k*std_w);
        g3(m-(w-1)/2,n-(w-1)/2) = f1(m,n) >= T(m-(w-1)/2,n-(w-1)/2);
    end 
end
figure (11); imshow(g3);

%% Sauvola Method - Local
w = 35;
k = 0.03;
f1 = padarray(f,[(w-1)/2 (w-1)/2],'symmetric','both');
std_im = 128;
for m=(1+(w-1)/2):M+2
    for n=(1+(w-1)/2):N+2
        window = f1(m-(w-1)/2:m+(w-1)/2,n-(w-1)/2:n+(w-1)/2);
        std_w = std2(window);
        mean_w = mean2(window);
        T(m-(w-1)/2,n-(w-1)/2) = mean_w*(1-k*(1-(std_w/std_im)));
        g4(m-(w-1)/2,n-(w-1)/2) = f1(m,n) >= T(m-(w-1)/2,n-(w-1)/2);
    end 
end
figure (12); imshow(g4);
for 
