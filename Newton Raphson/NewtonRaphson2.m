%This program may not be distributed WITHOUT the authorization of its creator :)

Ybus=[2-20i -1+10i -1+10i ; -1+10i 2-20i -1+10i; -1+10i -1+10i 2-20i]



Nodos = xlsread('Nodos.xlsx');


G=real(Ybus);
B=imag(Ybus);
z=size(Nodos,1);
V=Nodos(:,3);
Pg=Nodos(:,5);
Qg=Nodos(:,6);
Pd=Nodos(:,7);
Qd=Nodos(:,8);
Bus=Nodos(:,2);
theta=Nodos(:,4)


x=[];
x2=[];

n=1;
%----------------------------------Crear vector de estados
while n<=z
    if(Bus(n)==2)  %PV
       
        x=[x ;theta(n)];
    end
    if(Bus(n)==3)

        x=[x ;theta(n) ;V(n)];
    end
    n=n+1
end


a=0
D=[0]
while D~=1
n=1;
Vt=V.*exp(j*theta)
VD=zeros(z);
VD=diag(Vt);

%-----------------------------------------------Pcal
    S=VD*conj(Ybus*Vt) 
    P=real(S);
    Q=imag(S);
%------------------------------Vector de Desajustes y delta X
        %---------------------deltaX: 1=Ángulo, 2 = Voltaje
        deltaX=zeros(z,0) ;  
        deltaD=zeros(z,0);
    while n<=z
    if(Bus(n)==2)  %PV
        deltaP=Pg(n)-Pd(n)-P(n);
        deltaD=[deltaD deltaP];
        deltaX=[deltaX; 1 n];
        
    end
    if(Bus(n)==3)
        deltaP=Pg(n)-Pd(n)-P(n);
        deltaQ=Qg(n)-Qd(n)-Q(n);
        deltaD=[deltaD deltaP deltaQ];
        deltaX=[deltaX; 1 n ;2 n];
        
    end
    
    n=n+1;
    end
    
    deltaD=deltaD';
    
 %-------------------------------------------------------------------Jacobiano
 J=Jacobiano(deltaX, G, B, V, P, Q, theta,z,Bus)
    
    
   %-----------------------------------------------------------------Nuevo delta D
   
   deltaXN=inv(J)*deltaD
    
   %-------------------------------------------------Actualizar variables de estado
   
   x=x+deltaXN;
   
   %---------------------------------------Reinsertar variables de estado en "Nodos"
   
   f=size(deltaX,1);
   n=1
   while n<=f
       if deltaX(n)==1   %teta
           
           theta(deltaX(n,2))=x(n)
       else              %V
           V(deltaX(n,2))=x(n)
       end
       n=n+1;
   end
           
  a=a+1;
  %------------------------------------------------Condición de paro
  D=abs(deltaD)<1E-03  %D=1 cuando se cumple la condición

end
   

%----------------------/// FLUJOS ///-------------------------------

        k=1;
        m=2;
        n=1;
        
        Pfnr=[];
n=1;
p=2;   
    while n<=z
        while p<=z
            I=-(Vt(n)-Vt(p))*(Ybus(n,p));
            S=Vt(n)*conj(I);
            Pfnr= [Pfnr ;n p real(S) imag(S)];
            p=p+1;
        end
        n=n+1;
        p=1;
    end
    
     k=1;
        m=2;
        n=1;
        
        
        Pf(n)=G(k,k)*V(k)^2+V(k)*V(m)*(G(k,m)*cos(theta(k)-theta(m))+B(k,m)*sin(theta(k)-theta(m)));
        
        Qf(n)=-B(k,k)*V(k)^2+ V(k)*V(m)*(G(k,m)*sin(theta(k)-theta(m))-B(k,m)*cos(theta(k)-theta(m)));
        





   
   