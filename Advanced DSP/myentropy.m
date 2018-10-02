function o=myentropy(s)
o=0;
for i=1:length(s)
    if s(i)~=0
        c=s(i)^2;
        o=o+c*log(c);
    end
end
end