function [y1,y2,y3,y4]=GaussSeidel(Ybus,Nodos,tol)

%Ybus=[2-20i -1+10i -1+10i ; -1+10i 1-10i 0  ; -1+10i 0 1-10i]
        
%Ybus=[2-20i -1+10i -1+10i ; -1+10i 2-20i -1+10i; -1+10i -1+10i 2-20i]

%Nodos = xlsread('Nodos.xlsx');

V=Nodos(:,3);
Pg=Nodos(:,5);
Qg=Nodos(:,6);
Pd=Nodos(:,7);
Qd=Nodos(:,8);
Nodo=Nodos(:,1);
Bus=Nodos(:,2);
z=size(Nodos,1);

Pd=Pd*-1;
Qd=Qd*-1;
n=1;
VT=V;
%tol=1E-5;
ite=0;
x=1;
a=1;
while tol<=x
while n<=z   
    
   if(Bus(n))==2
       V=PV(V,Pg, z, n, Ybus, VT);
       
    end
    
    if(Bus(n)==3)
        V=PQ(V,Pd,Qd,z,n,Ybus);
        
    end
    
    
    n=n+1;
end
ite=ite+1;
VT=[VT V];

toler=tolerance(VT,ite);

x=max(toler);
n=1;
%tol=tol+1;
a=a+1;
end

x=size(VT,2);

VT2=VT(:,9);

theta=imag(VT2);
V=real(VT2);

%-------------------------FLUJOS--------------------------
Vt=V.*exp(j*theta);

   k=1;
        m=2;
        n=1;
        
        PfGS=[];
n=1;
p=2;   
    while n<=z
        while p<=z
            I=-(Vt(n)-Vt(p))*(Ybus(n,p));
            S=Vt(n)*conj(I);
            PfGS= [PfGS ;n p real(S) imag(S)];
            p=p+1;
        end
        n=n+1;
        p=1;
    end


    y1=theta;
    y2=V;
    y3=PfGS;
    y4=a;
end

    
    
