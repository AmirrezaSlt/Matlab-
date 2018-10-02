clc
clear
close all
[hd,gd,hr,gr]=wfilters('db6');
for i=0:6
    o=0;
    for j=1:length(hr)
        if ismember(j-2*i,1:length(hr))
        o=o+hr(j).*conj(hr(j-2*i));
        end
    end
    s(i+1)=o;
end
s