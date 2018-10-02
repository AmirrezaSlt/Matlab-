%Q1HW3
clc
clear
close all

image = imread('teapot.jpg');
f = rgb2gray(image);
f = im2double(f);
[M,N] = size(f);

% %% plot Image and its Histogram
for m=1:M
    for n=1:N
        v=f(m,n);
        h(v+1)=h(v+1)+1;
    end
end

 p = h_original./numel(f); % Creat PDF function of histogram 
 figure (1); imshow(f,[]); title(['Original image - Size = [' num2str(M) ',' num2str(N) ']']);
 figure,plot(h_original);

% %% Uniform Quantization
% uniform_level = 4;         % Number of quantization levels
% %v = 256/uniform_level;
% f_uniform = fix(f*uniform_level/256);
% h_uniform = our_hist(uint8(f_uniform));
% %h_uniform (uniform_level+1:256) =[];
% 
% figure (3); imshow(f_uniform,[]); title(['Image Quantized Uniformly - L=' num2str(uniform_level)]);

%% Lloyd-Max Method
w = f;
h = imhist(w);   % Obtain histogram of Image
p = h./numel(w); % Creat PDF function of histogram 

%%%% Gamma Correction extra part
% gamma = 0.5;
% w = 255^(1-gamma).*(double(f).^gamma);
% h = imhist(uint8(w));   % Obtain histogram of Image that obtain "Gamma" correction
% p = h./numel(w);        % Creat PDF function of histogram 
%%%%

uniform_level = 4;          % Set quantization's levels
v = 256/uniform_level;
t = 0:v:256;     % Uniform quantization level for initialization
tt=0; r=0;
for iteration = 1:10
    for k = 1:uniform_level
        Numerator = (t(k):t(k+1)-1)*p(t(k)+1:t(k+1));
        Denominator = sum(p(t(k)+1:t(k+1)));
        r(k) = Numerator/Denominator;
    end
    r(isnan(r))=0;  % Substitute "NaN" with "0" in r(k)
    for k = 2:uniform_level
        t(k) = (r(k)+r(k-1))/2;
        tt(iteration,k-1) = t(k);
    end
end
t = round(t);
for i=1:length(t)-1
    for m=1:M
        for n=1:N
            if  w(m,n)>=t(i)  && w(m,n)<t(i+1)
                f_uniform(m,n) = r(i);
            end
        end
    end 
end

figure (5); imshow(f_uniform,[]); title(['Image Quantized by Lloyd-Max Method - L=' num2str(uniform_level)]);


tt = [zeros(size(tt,1),1),tt,256*ones(size(tt,1),1)];
tt = [(0:v:256);tt];
x = 1:size(tt,1);
figure (6); plot(x,tt); title(['Convergence of Lloyd-Max in ' num2str(uniform_level) ' Levels quantization']); xlabel('Iteration'); ylabel('Levels')
