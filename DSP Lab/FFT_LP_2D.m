function output_image=FFT_LP_2D (input_image,cutoff_frequency,passband_gain)

s = size(input_image);
filter = zeros(s);
I=(s(1)+1)/2;
J=(s(2)+1)/2;


in_fft = fftshift(fft2(input_image));


%(cutoff_frequency/(2*pi))*s(1)
%(cutoff_frequency/(2*pi))*s(2)
for i=0:(cutoff_frequency/(2*pi))*s(1)
    for j=0:(cutoff_frequency/(2*pi))*s(2)
        if ( i / ( ( cutoff_frequency/ (2*pi) ) * s(1) ) )^2  + (j/((cutoff_frequency/(2*pi))*s(2)))^2 <= 1
        i1 = floor(I+i);
        i2 = ceil(I-i);
        j1 = floor(J+j);
        j2 = ceil(J-j);
            filter(i1,j1) = passband_gain;
            filter(i1,j2) = passband_gain;
            filter(i2,j1) = passband_gain;
            filter(i2,j2) = passband_gain;
            
        end
    end
end



out_fft = in_fft .* filter;
output_image = ifft2(ifftshift(out_fft),'symmetric');

end


