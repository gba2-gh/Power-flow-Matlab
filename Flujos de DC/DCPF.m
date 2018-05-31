function y=DCPF(Ybus,Nodos)


%Ybus=[2-20i -1+10i -1+10i ; -1+10i 2-20i -1+10i; -1+10i -1+10i 2-20i]

%Nodos = xlsread('Nodos.xlsx');


G=real(Ybus);
B=imag(Ybus);

z=size(Nodos,1);
V=Nodos(:,3);
Bus=Nodos(:,2);
theta=Nodos(:,4);
Pg=Nodos(:,5);
Qg=Nodos(:,6);
Pd=Nodos(:,7);
Qd=Nodos(:,8);

x=[];

thetaDC=theta;
BDC=B;
n=1;
deltaP=Pg-Pd;
%---------------------------------------------obtener angulos para metodo
      while n<=z
       if Bus(n)==1
        BDC(n,:)=[];
        BDC(:,n)=[];
        deltaP(n,:)=[];
        thetaDC(n)=[0];
       end
        n=n+1;
      end
      
thetaDC=inv(BDC)*deltaP;

%-----------------------------------------------Sobreescribir vector theta

n=1;
p=1;
      while n<=z
       if Bus(n)==2
        theta(n)=thetaDC(p);
        p=p+1;
       end
       if Bus(n)==3
        theta(n)=thetaDC(p);
        p=p+1;
       end
        n=n+1;
      end

%------------------------------------------------Flujos
Pfdc=[];
n=1;
p=2;   
    while n<=z
        while p<=z
            Pfdc= [Pfdc ;n p (theta(p)-theta(n))*B(n,p)];
            p=p+1;
        end
        n=n+1;
        p=1;
end
              
        y=Pfdc;
        end
         
         


