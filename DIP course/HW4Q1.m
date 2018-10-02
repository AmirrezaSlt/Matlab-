clc
clear
close all
d_old=[0, 2; 3, 1];
for iter=2:10
    d1=4*d_old;
    d2 = 4 * d_old + 2;
    d3 = 4 * d_old + 3;
    d4 = 4 * d_old + 1;
    d_column1 = cat(1, d1, d3);
    d_column2 = cat(1, d2, d4);
    size = 2 ^ iter;
    d_new = cat(2, d_column1, d_column2);
    if size == 4
        ordered_matrix_4 = d_new;
    elseif size == 8
        ordered_matrix_8 = d_new;
    end
    d_old = d_new;
end


%%%%%%%%%%%%%%%%%%%%%% Section (B) %%%%%%%%%%%%%%%%%%%%%%%%

f0 = 1/100;
for x=1:250
    for y=1:250
        r = sqrt((x-125)^2 + (y-125)^2);
        if r<50
            f(x, y) = cos(2*pi*f0*(r) + pi) + 1;
        elseif r<100
            f(x, y) = cos(2*pi*f0*(r-50) + pi) + 1;
        elseif r<150
            f(x, y) = cos(2*pi*f0*(r-100) + pi) + 1;
        elseif r<200
            f(x, y) = cos(2*pi*f0*(r-150) + pi) + 1;
        elseif r<250
            f(x, y) = cos(2*pi*f0*(r-200) + pi) + 1;
        end
    end
end
figure(1), imshow(f), title('f original')


%%%%%%%%%%%%%%%%%%%%%% Section (C) %%%%%%%%%%%%%%%%%%%%%%%%

for i=1:2:249
    for j=1:2:249
        f_ordered_2(i:i+1, j:j+1) = ordered_matrix_2 .* f(i:i+1, j:j+1);
    end
end
for i=1:4:247
    for j=1:4:247
        f_ordered_4(i:i+3, j:j+3) = ordered_matrix_4 .* f(i:i+3, j:j+3);
    end
end
for i=1:8:243
    for j=1:8:243
        f_ordered_8(i:i+7, j:j+7) = ordered_matrix_8 .* f(i:i+7, j:j+7);
    end
end
figure(2), imshow(f_ordered_2), title('2D Ordered Dither of f')
figure(3), imshow(f_ordered_4), title('4D Ordered Dither of f')
figure(4), imshow(f_ordered_8,[]), title('8D Ordered Dither of f')


%%%%%%%%%%%%%%%%%%%%%% Section (D) %%%%%%%%%%%%%%%%%%%%%%%%

errdiff_f = error_diffusion(f);
dotdiff_f = dot_diffusion(f);
figure(5), imshow(errdiff_f), title('Halftoned f with Error Diffusion');
figure(6), imshow(dotdiff_f), title('Halftoned f with Dot Diffusion');