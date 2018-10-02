function histequal = histogram_equalization(f)
    [M, N] = size(f);
    histogram = zeros(1, 256);
    for m=1:M
        for n=1:N
            r = f(m, n);
            histogram(r+1) = histogram(r+1) + 1;
        end
    end
    p = histogram / (M*N);
    f_cdf(1) = p(1);
    for k=2:256
        f_cdf(k) = p(k) + f_cdf(k-1);
    end
    for m=1:M
        for n=1:N
            r = f(m, n);
            histequal(m, n) = f_cdf(r+1);
        end
    end
end