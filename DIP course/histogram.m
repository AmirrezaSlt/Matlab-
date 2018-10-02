function hist = histogram( f )
    [M, N] = size(f);
    hist = zeros(1, 256);
    for m=1:M
        for n=1:N
            r = f(m, n);
            hist(r+1) = hist(r+1) + 1;
        end
    end
end

