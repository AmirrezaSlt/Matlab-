% clc
% clear
% close all
d=0.25*[0 2;3 1];
disp('size=4 :')
N2dither(4,d)
disp('size=8 :')
N2dither(8,d)
f0=1/200;
f=zeros(250,250);
for x=1:250
    for y=1:250
        r=sqrt((x-125)^2+(y-125)^2); % Circle Equation
        if r<50
        f(x,y)=sin(2*pi*(f0*r));
        elseif r<100
           f(x,y)=sin(2*pi*f0*(r-50));
        elseif r<150
                f(x,y)=sin(2*pi*f0*(r-100));
        elseif r<200
                  f(x,y)=sin(2*pi*f0*(r-150));
                    end
    end
end
figure,imshow(f,[])
d2=0.25*[1 0;1 1];
for i=1:2:249
    for j=1:2:249
        fd2(i:i+1,j:j+1)=d.*f(i:i+1,j:j+1);
    end
end
for i=1:4:247
    for j=1:4:247
        fd4(i:i+3,j:j+3)=N2dither(4,d).*f(i:i+3,j:j+3);
    end
end
for i=1:8:243
    for j=1:8:243
        fd8(i:i+7,j:j+7)=N2dither(8,d).*f(i:i+7,j:j+7);
    end
end
figure,imshow(fd2),title('2D Ordered Dither with D=[0,2;3,1]')
figure,imshow(fd4),title('4D Ordered Dither with D=[0,2;3,1]')
figure,imshow(fd8,[]),title('8D Ordered Dither with D=[0,2;3,1]')
for i=1:2:249
    for j=1:2:249
        f2d2(i:i+1,j:j+1)=d2.*f(i:i+1,j:j+1);
    end
end
for i=1:4:247
    for j=1:4:247
        f2d4(i:i+3,j:j+3)=N2dither(4,d2).*f(i:i+3,j:j+3);
    end
end
for i=1:8:243
    for j=1:8:243
        f2d8(i:i+7,j:j+7)=N2dither(8,d2).*f(i:i+7, j:j+7);
    end
end
figure,imshow(f2d2),title('2D Ordered Dither with D=[1,0;1,1]')
figure,imshow(f2d4),title('4D Ordered Dither with D=[1,0;1,1]')
figure,imshow(f2d8,[]),title('8D Ordered Dither with D=[1,0;1,1]')
function o=N2dither(n,d)
   x=log2(n);
   if x~=1
     for i=2:x
         k=4*(i^2);
         d=(1/k)*[k*d,k*d+2;k*d+3,k*d+1];
     end
   end 
   o=d;
end


