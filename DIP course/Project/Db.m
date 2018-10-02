function o=Db(di,k,alpha)
o=di.*exp(-(abs(di/k)).^(alpha+1));
end

