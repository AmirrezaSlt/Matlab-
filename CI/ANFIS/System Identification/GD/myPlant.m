function y_kp1=myPlant(y_k,y_km1,y_km2,u_k,u_km1)

    y_kp1=(5*y_k*y_km1)/(1+y_k^2+y_km1^2+y_km2^2)+u_k+0.8*u_km1;
end