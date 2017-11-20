%------------------POWER FLOW------------------------------

%Ybus=[2-20i -1+10i -1+10i ; -1+10i 2-20i -1+10i; -1+10i -1+10i 2-20i];

Ybus=MatrizAdmitanciasNodales

G=real(Ybus);
B=imag(Ybus);

Nodos = xlsread('Nodos.xlsx');

tolNR=1E-03;
tolDR=1E-03;
tolGS=1E-05;

[thetaNR,VNR,PfNR,itNR]=NewtonRaphson(Ybus, Nodos,tolNR)
%[thetaDR,VDR,PfDR,itDR]=DesacopladoRapido(Ybus,Nodos,tolDR);
%[thetaGS,VGS,PfGS,itGS]=GaussSeidel(Ybus,Nodos,tolGS);
%PfDC=DCPF(Ybus,Nodos);
