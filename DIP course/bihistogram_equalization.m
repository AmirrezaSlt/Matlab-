function bihistequal = bihistogram_equalization(f)
    [M, N] = size(f);
    histogram = zeros(1, 256);
    for m=1:M
        for n=1:N
            r = f(m, n);
            h(r+1) = h(r+1) + 1;
        end
    end
    p = histogram / (M*N);
    for i=1:M*N
        T = sum(p(i)*i) / 256;
    end
    p1 = p(1:T);
    p2 = p(T+1:M*N);
    for k=1:256
        f_cdf1(r) = sum(p1(1:k));
        f_cdf2(r) = sum(p2(1:k));
    end
    f_cdf(r) = [f_cdf1, f_cdf2];
    for x=1:M
        for y=1:N
            r = f(m, n);
            bihistequal(x, y) = f_cdf(r+1);
        end
    end
end

