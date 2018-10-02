clc
clear all
close all

%% Input Data

%initial oil pressure(psi)
Poi=input('Initial Oil Pressure(Psi)[5000]: ');
if isempty(Poi)
    Poi=5000;
end
%initial water saturation
Swi=input('Initial Water Saturation[0]: ');
if isempty(Swi)
    Swi=0.0001;
end
%porosity
Phi=input('Porosity[0.2]: ');
if isempty(Phi)
    Phi=0.2;
end
%reservoir area(squared ft)
X=input('Reservoir Area(squared ft)[1,000,000]: ');
if isempty(X)
    X=1000000;
end
XX=X^0.5;
%reservoir tickness(ft)
deltaz=input('Reservoir Thickness(ft)[100]: ');
if isempty(deltaz)
    deltaz=100;
end
%number of grids in the system
m=input('Number of Grids[64]: ');
if isempty(m)
    m=64;
end
m=m^0.5;
%reservoir permeability
K = [100 80 70 60 70 75 60 70;80 100 80 55 90 70 60 90;85 70 100 80 85 90 75 70;50 60 70 100 80 70 60 70;80 70 60 70 100 80 70 60;80 70 60 70 50 100 55 75;60 75 80 85 90 75 100 80;55 90 70 75 80 85 90 100];
%rock compressibility(1/psi)
format long
Cr=input('Rock Compressibility(1/psi)[10*10^-6]: ');
if isempty(Cr)
    Cr=10*10^-6;
end
%water injection rate(STB/D)
Qscw=input('Injection Rate (STB/D)[200]: ');
if isempty(Qscw)
    Qscw=200;
end
%grid size(ft)
deltax = ones(m)*(XX/m);
deltay = deltax;

%initial allocation
Po=Poi.*ones(m);
Sw=(Swi)*ones(m);
TxoPlus=ones(m);
TyoPlus=ones(m);
TxoMinus=ones(m);
TyoMinus=ones(m);
TxwPlus=ones(m);
TywPlus=ones(m);
TxwMinus=ones(m);
TywMinus=ones(m);

%oil and water volume factor
Bo=1.2;
Bw=1;

% [0.010 0.0075 0.0050 0.0025 0.001 0.0005]
cx = 0;
cc = 1;
%time step(day)
t = 5;
%start
time = 0;
%produced oil(STB)
Qo_sum = 0;

%time loop which continue until WCT=0.95
while time <= inf
    time = time + t;
    
    %assign previous oil pressure
    Poo=Po;
    %assign previous water saturation
    Sww=Sw;
    %oil relative permeability estimation
    Kro = (1-Sw);
    %water relative permeability estimation
    Krw = Sw;
    %capillary pressure estimation
    [a1, b1] = size(Sw);
    Pc = zeros(a1,b1);
    %oil relative permeability estimation to calculate Pc derivative
    [a2, b2] = size(Sw);
    Pc0 = zeros(a2,b2);    
    %derivative of Pc with respect to Sw
    PctoSw = (Pc0-Pc)./(0.001*Sw);
    %water pressure calculation for first time step
    if time == t
        Pw=Po-Pc;
    end
    %derivative of Bw with respect to Pw
    BwtoPw=0;
    %derivative of Bo with respect to Po
    BotoPo=0;
    %water vicousity(cp)
    Muw=1;
    %oil viscousity(cp)
    Muo=5;
    
    Landao=Kro./((Muo.*Bo));
    Landaw=Krw./((Muw.*Bw));
    %grid block volume(ft^3)
    Vb=deltaz*deltax.*deltay;
    %unit correction coefficients
    Beta_c = 0.001127;
    alpha_c = 5.615;
    
    %=================== Transmissibility Calculation ===================%
    %TyoPlus
    for i=1:m
        for j=1:m-1
            if Po(i,j+1)>=Po(i,j)
                TyoPlus(i,j)=2*Beta_c*Vb(i,j)*K(i,j)*Landao(i,j+1)/((deltay(i,j)*(deltay(i,j)+deltay(i,j+1))));
            else
                TyoPlus(i,j)=2*Beta_c*Vb(i,j)*K(i,j)*Landao(i,j)/((deltay(i,j)*(deltay(i,j)+deltay(i,j+1))));
            end
        end
    end
    %No flow boundary
    TyoPlus(:,m)=0;
    %TyoMinus
    for i=1:m
        for j=2:m
            if Po(i,j-1)>=Po(i,j)
                TyoMinus(i,j)=2*Beta_c*Vb(i,j)*K(i,j)*Landao(i,j-1)/((deltay(i,j)*(deltay(i,j)+deltay(i,j-1))));
            else
                TyoMinus(i,j)=2*Beta_c*Vb(i,j)*K(i,j)*Landao(i,j)/((deltay(i,j)*(deltay(i,j)+deltay(i,j-1))));
            end
        end
    end
    %No flow boundary
    TyoMinus(:,1)=0;
    %TxoPlus
    for i=1:m-1
        for j=1:m
            if Po(i+1,j)>=Po(i,j)
                TxoPlus(i,j)=2*Beta_c*Vb(i,j)*K(i,j)*Landao(i+1,j)/((deltax(i,j)*(deltax(i,j)+deltax(i+1,j))));
            else
                TxoPlus(i,j)=2*Beta_c*Vb(i,j)*K(i,j)*Landao(i,j)/((deltax(i,j)*(deltax(i,j)+deltax(i+1,j)))) ;
            end
        end
    end
    %No flow boundary
    TxoPlus(m,:)=0;
    %TxoMinus
    for i=2:m
        for j=1:m
            if Po(i-1,j)>=Po(i,j)
                TxoMinus(i,j)=2*Beta_c*Vb(i,j)*K(i,j)*Landao(i-1,j)/((deltax(i,j)*(deltax(i,j)+deltax(i-1,j))));
            else
                TxoMinus(i,j)=2*Beta_c*Vb(i,j)*K(i,j)*Landao(i,j)/((deltax(i,j)*(deltax(i,j)+deltax(i-1,j))));
            end
        end
    end
    %No flow boundary
    TxoMinus(1,:)=0;
    %TywPlus
    for i=1:m
        for j=1:m-1
            if Pw(i,j+1)>=Pw(i,j)
                TywPlus(i,j)=2*Beta_c*Vb(i,j)*K(i,j)*Landaw(i,j+1)/((deltay(i,j)*(deltay(i,j)+deltay(i,j+1))));
            else
                TywPlus(i,j)=2*Beta_c*Vb(i,j)*K(i,j)*Landaw(i,j)/((deltay(i,j)*(deltay(i,j)+deltay(i,j+1))));
            end
        end
    end
    %No flow boundary
    TywPlus(:,m)=0;
    %TywMinus
    for i=1:m
        for j=2:m
            if Pw(i,j-1)>=Pw(i,j)
                TywMinus(i,j)=2*Beta_c*Vb(i,j)*K(i,j)*Landaw(i,j-1)/((deltay(i,j)*(deltay(i,j)+deltay(i,j-1))));
            else
                TywMinus(i,j)=2*Beta_c*Vb(i,j)*K(i,j)*Landaw(i,j)/((deltay(i,j)*(deltay(i,j)+deltay(i,j-1))));
            end
        end
    end
    %No flow boundary
    TywMinus(:,1)=0;
    %TxwPlus
    for i=1:m-1
        for j=1:m
            if Pw(i+1,j)>=Pw(i,j)
                TxwPlus(i,j)=2*Beta_c*Vb(i,j)*K(i,j)*Landaw(i+1,j)/((deltax(i,j)*(deltax(i,j)+deltax(i+1,j))));
            else
                TxwPlus(i,j)=2*Beta_c*Vb(i,j)*K(i,j)*Landaw(i,j)/((deltax(i,j)*(deltax(i,j)+deltax(i+1,j))));
            end
        end
    end
    %No flow boundary
    TxwPlus(m,:)=0;
    %TxwMinus
    for i=2:m
        for j=1:m
            if Pw(i-1,j)>=Pw(i,j)
                TxwMinus(i,j)=2*Beta_c*Vb(i,j)*K(i,j)*Landaw(i-1,j)/((deltax(i,j)*(deltax(i,j)+deltax(i-1,j))));
            else
                TxwMinus(i,j)=2*Beta_c*Vb(i,j)*K(i,j)*Landaw(i,j)/((deltax(i,j)*(deltax(i,j)+deltax(i-1,j))));
            end
        end
    end
    %No flow boundary
    TxwMinus(1,:)=0;
    
    
    Cpoo=(Phi.*(1-Sw).*Vb.*((Cr./Bo)+BotoPo))./(alpha_c*t);
    Cpow=(Phi.*Sw.*Vb.*((Cr./Bw)+BwtoPw))/(alpha_c*t);
    Csww=(Vb.*Phi./(alpha_c*Bw*t))-((PctoSw).*(Cpow)/alpha_c);
    Cswo=-Vb.*Phi./(alpha_c*Bo*t);
    alpha=-Cswo./Csww;
    
    %======================== Pressure Calculation ========================%
    %coefficients of Po(i-1,j)
    A=(TxoMinus+alpha.*TxwMinus);
    %coefficients of Po(i,j)
    B=-(TxoPlus+alpha.*TxwPlus)-(TxoMinus+alpha.*TxwMinus)-(TyoPlus+alpha.*TywPlus)-(TyoMinus+alpha.*TywMinus)-(Cpoo+alpha.*Cpow);
    %coefficients of Po(i+1,j)
    C=(TxoPlus+alpha.*TxwPlus);
    %coefficients of Po(i,j+1)
    D=(TyoPlus+alpha.*TywPlus);
    %coefficients of Po(i,j-1)
    E=(TyoMinus+alpha.*TywMinus);
    %right hanside term_part1
    F = zeros(m);
    for i=2:m-1
        for j=2:m-1
            F(i,j)=alpha(i,j)*(TxwPlus(i,j)*(Pc(i+1,j)-Pc(i,j))+TxwMinus(i,j)*(Pc(i-1,j)-Pc(i,j))+TywPlus(i,j)*(Pc(i,j+1)-Pc(i,j))+TywMinus(i,j)*(Pc(i,j-1)-Pc(i,j)))-Po(i,j)*(Cpoo(i,j)+alpha(i,j)*Cpow(i,j));
        end
    end
    for i=2:m-1
        for j=1
            F(i,j)=alpha(i,j)*(TxwPlus(i,j)*(Pc(i+1,j)-Pc(i,j))+TxwMinus(i,j)*(Pc(i-1,j)-Pc(i,j))+TywPlus(i,j)*(Pc(i,j+1)-Pc(i,j)))-Po(i,j)*(Cpoo(i,j)+alpha(i,j)*Cpow(i,j));
        end
    end
    for i=2:m-1
        for j=m
            F(i,j)=alpha(i,j)*(TxwPlus(i,j)*(Pc(i+1,j)-Pc(i,j))+TxwMinus(i,j)*(Pc(i-1,j)-Pc(i,j))+TywMinus(i,j)*(Pc(i,j-1)-Pc(i,j)))-Po(i,j)*(Cpoo(i,j)+alpha(i,j)*Cpow(i,j));
        end
    end
    for j=2:m-1
        for i=1
            F(i,j)=alpha(i,j)*(TxwPlus(i,j)*(Pc(i+1,j)-Pc(i,j))+TywPlus(i,j)*(Pc(i,j+1)-Pc(i,j))+TywMinus(i,j)*(Pc(i,j-1)-Pc(i,j)))-Po(i,j)*(Cpoo(i,j)+alpha(i,j)*Cpow(i,j));
        end
    end
    for j=2:m-1
        for i=m
            F(i,j)=alpha(i,j)*(TxwMinus(i,j)*(Pc(i-1,j)-Pc(i,j))+TywPlus(i,j)*(Pc(i,j+1)-Pc(i,j))+TywMinus(i,j)*(Pc(i,j-1)-Pc(i,j)))-Po(i,j)*(Cpoo(i,j)+alpha(i,j)*Cpow(i,j));
        end
    end
    %geometrical coefficient of production well
    FF = 1;
    s = 0;
    rw = 0.5;
    re = 0.198 * deltax(1,m);
    Gw_star = (2*pi*Beta_c*K(1,m)*deltaz) / (log(re/rw) + s);
    Pwh = Poi;
    Gw = Gw_star * FF;
    %right hanside term_part2
    F(1,1)=alpha(1)*(TxwPlus(1,1)*(Pc(2,1)-Pc(1,1))+TywPlus(1,1)*(Pc(1,2)-Pc(1,1)))-Po(1,1)*(Cpoo(1,1)+alpha(1,1)*Cpow(1,1));
    F(1,m)=alpha(1,m)*(TxwPlus(1,m)*(Pc(2,m)-Pc(1,m))+TywMinus(1,m)*(Pc(1,m-1)-Pc(1,m)))-Po(1,m)*(Cpoo(1,m)+alpha(1,m)*Cpow(1,m))-Gw*(Landao(1,m)*Pwh + alpha(1,m)*Landaw(1,m)*(Pc(1,m)+Pwh));
    B(1,m)=-(TxoPlus(1,m)+alpha(1,m)*TxwPlus(1,m))-(TxoMinus(1,m)+alpha(1,m)*TxwMinus(1,m))-(TyoPlus(1,m)+alpha(1,m)*TywPlus(1,m))-(TyoMinus(1,m)+alpha(1,m)*TywMinus(1,m))-(Cpoo(1,m)+alpha(1,m)*Cpow(1,m))-Gw*(Landao(1,m)+alpha(1,m)*Landaw(1,m));
    F(m,1)=alpha(m,1)*(TywPlus(m,1)*(Pc(m,2)-Pc(m,1))+TxwMinus(m,1)*(Pc(m-1,1)-Pc(m,1)))-Po(m,1)*(Cpoo(m,1)+alpha(m,1)*Cpow(m,1))-alpha(m,1)*Qscw;
    F(m,m)=alpha(m,m)*(TxwMinus(m,m)*(Pc(m-1,m)-Pc(m,m))+TywMinus(m,m)*(Pc(m,m-1)-Pc(m,m)))-Po(m,m)*(Cpoo(m,m)+alpha(m,m)*Cpow(m,m));
    
    %initial allocation
    CC = zeros(m^2);
    BB = zeros(1,m^2);
    
    %creation coefficients matrix
    for i=1:m^2
        CC(i,i)=B(i);
        if i>=1 && i<=(m^2-1)
            CC(i,i+1)=C(i);
            CC(i+1,i)=A(i+1);
        end
        if i>=1 && i<=(m^2-m)
            CC(i,i+m)=D(i);
            CC(i+m,i)=E(i+m);
        end
    end
    for i=1:m^2
        BB(i)=F(i);
    end
    %oil pressure is calculated and assigned to its true location
    BBB=BB';
    PM=CC\BBB;
    for i=1:m
        Po(:,i)=PM(1+(i-1)*m:i*m);
    end
    %water pressure is calculated from Po and Pc
    Pw=Po-Pc;
    
    %===================== Saturation Calculation =========================%
    for i=2:m-1
        for j=2:m-1
            Sw(i,j)=Sww(i,j)+(1/Cswo(i,j))*(TxoPlus(i,j)*(Po(i+1,j)-Po(i,j))+TxoMinus(i,j)*(Po(i-1,j)-Po(i,j))+TyoPlus(i,j)*(Po(i,j+1)-Po(i,j))+TyoMinus(i,j)*(Po(i,j-1)-Po(i,j))-Cpoo(i,j)*(Po(i,j)-Poo(i,j)));
        end
    end
    for i=2:m-1
        for j=1
            Sw(i,j)=Sww(i,j)+(1/Cswo(i,j))*(TxoPlus(i,j)*(Po(i+1,j)-Po(i,j))+TxoMinus(i,j)*(Po(i-1,j)-Po(i,j))+TyoPlus(i,j)*(Po(i,j+1)-Po(i,j))-Cpoo(i,j)*(Po(i,j)-Poo(i,j)));
        end
    end
    for i=2:m-1
        for j=m
            Sw(i,j)=Sww(i,j)+(1/Cswo(i,j))*(TxoPlus(i,j)*(Po(i+1,j)-Po(i,j))+TxoMinus(i,j)*(Po(i-1,j)-Po(i,j))+TyoMinus(i,j)*(Po(i,j-1)-Po(i,j))-Cpoo(i,j)*(Po(i,j)-Poo(i,j)));
        end
    end
    for j=2:m-1
        for i=1
            Sw(i,j)=Sww(i,j)+(1/Cswo(i,j))*(TxoPlus(i,j)*(Po(i+1,j)-Po(i,j))+TyoPlus(i,j)*(Po(i,j+1)-Po(i,j))+TyoMinus(i,j)*(Po(i,j-1)-Po(i,j))-Cpoo(i,j)*(Po(i,j)-Poo(i,j)));
        end
    end
    for j=2:m-1
        for i=m
            Sw(i,j)=Sww(i,j)+(1/Cswo(i,j))*(TxoMinus(i,j)*(Po(i-1,j)-Po(i,j))+TyoPlus(i,j)*(Po(i,j+1)-Po(i,j))+TyoMinus(i,j)*(Po(i,j-1)-Po(i,j))-Cpoo(i,j)*(Po(i,j)-Poo(i,j)));
        end
    end
    Sw(1,1)=Sww(1,1)+(1/Cswo(1,1))*(TxoPlus(1,1)*(Po(2,1)-Po(1,1))+TyoPlus(1,1)*(Po(1,2)-Po(1,1))-Cpoo(1,1)*(Po(1,1)-Poo(1,1)));
    %producing oil flowarte(STB/D)
    Qsco = Gw*Landao(1,m)*(Po(1,m)-Pwh);
    Sw(1,m)=Sww(1,m)+(1/Cswo(1,m))*(TxoPlus(1,m)*(Po(2,m)-Po(1,m))+TyoMinus(1,m)*(Po(1,m-1)-Po(1,m))-Cpoo(1,m)*(Po(1,m)-Poo(1,m))-Qsco);
    Sw(m,1)=Sww(m,1)+(1/Cswo(m,1))*(TxoMinus(m,1)*(Po(m-1,1)-Po(m,1))+TyoPlus(m,1)*(Po(m,2)-Po(m,1))-Cpoo(m,1)*(Po(m,1)-Poo(m,1)));
    Sw(m,m)=Sww(m,m)+(1/Cswo(m,m))*(TxoMinus(m,m)*(Po(m-1,m)-Po(m,m))+TyoMinus(m,m)*(Po(m,m-1)-Po(m,m))-Cpoo(m,m)*(Po(m,m)-Poo(m,m)));
    
    %producing oil flowrate is saved in a matrix for each timestep
    Qscoo(cc) = Qsco;
    %cummulative production
    Qo_sum = Qo_sum + Qsco*t;
    %cummulative production is saved in a matrix for each timestep
    Qsco_cum(cc) = Qo_sum;
    %producing water flowrate is saved in a matrix for each timestep
    QWW = Gw*Landaw(1,m)*(Pw(1,m)-Pwh);
    Qscww(cc) = QWW;
    %ellapsed time is saved in a matrix for each timestep
    time_step(cc) = time;
    %watercut calculation
    Water_Cut = Qscww(cc)/(Qscww(cc)+Qscoo(cc));
    Water_Cutt(cc) = Water_Cut;
    %wellbore pressure is saved in matrix for each timestep
    Pwf_inj(cc) = Pw(m,1) - (Qscw/(Gw*Landaw(m,1)));
    %calculation is stopped if watercut is greater than 0.95
    if Water_Cut > 0.95
        break
    end
    cc = cc + 1;
    %timestep is increased slowly to speed up
    if t < 0.01
        t = t*1.01;
    end
    
    %display results each 20 steps
    cond = rem(cc,20);
    if cond == 1
        clc
        disp('======================= Processing ============================')
        disp(['Ellapsed time(day) = ' num2str(time)])
        disp('***************************************************************')
        disp(['WaterCut = ' num2str(Water_Cut)])
        disp('***************************************************************')
        disp(['Oil Flowrate(STB/D) = ' num2str(Qsco)])
        disp('***************************************************************')
        disp(['Water Flowrate(STB/D) = ' num2str(QWW)])
        disp('***************************************************************')
        disp(['Cummulative Oil Production(STB) = ' num2str(Qo_sum )])
        disp('***************************************************************')
    end
    if (time >= 100 && cx == 0)
        Pos = Po;
        Krws = Krw;
        cx = 1;
    end
end

%================================== PLOT =================================%
%oil and water flowrate(STB/D)
figure
hold on
title('Flow Rate Versus Time')
xlabel('Time(Day)')
ylabel('Flow Rate(STB/D)')
grid on
plot(time_step,Qscoo,'k','linewidth',2.5)
plot(time_step,Qscww,'b','linewidth',2.5)
legend('Oil Flow Rate','Water Flow Rate')
hold off

%water cut
figure
plot(time_step,Water_Cutt,'k','linewidth',2.5)
title('Water Cut Versus Time')
xlabel('Time(Day)')
ylabel('Water Cut')
grid on


%recovery factor
figure
V_bulk = X*deltaz;
OIP = (V_bulk*Phi*(1-Swi))/alpha_c;
Recovery = (Qsco_cum)/OIP;
plot(time_step,Recovery,'k','linewidth',2.5)
title('Recovery Versus Time')
xlabel('Time(Day)')
ylabel('Recovery')
grid on


%Pressure profile
figure
title('Pressure Profile')
surf(Pos)
figure
surf(Po)

%Krw profile
figure
title('Krw Profile')
surf(Krws)
figure
surf(Krw)