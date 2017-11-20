Ybus=[2-20i -1+10i -1+10i ; -1+10i 2-20i -1+10i; -1+10i -1+10i 2-20i]

G=real(Ybus);
B=imag(Ybus);

Nodos = xlsread('Nodos.xlsx');

z=size(Nodos,1);
V=Nodos(:,3);
Bus=Nodos(:,2);
theta=Nodos(:,4)
Pg=Nodos(:,5);
Qg=Nodos(:,6);
Pd=Nodos(:,7);
Qd=Nodos(:,8);



x=[];

n=1;

%-------------------------------Vector de estados
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
        deltaD=[]
        deltaPdr=[]
        deltaQdr=[]
    while n<=z
    if(Bus(n)==2)  %PV
        deltaP=Pg(n)-Pd(n)-P(n);
        deltaD=[deltaD ;deltaP];
        deltaPdr=[deltaPdr; deltaP];
        deltaX=[deltaX; 1 n];
        
    end
    if(Bus(n)==3)
        deltaP=Pg(n)-Pd(n)-P(n);
        deltaQ=Qg(n)-Qd(n)-Q(n);
        deltaD=[deltaD ;deltaP; deltaQ];
        deltaPdr=[deltaPdr; deltaP ];
        deltaQdr=[deltaQdr; deltaQ]
        deltaX=[deltaX; 1 n ;2 n];
        
    end
    
    n=n+1;
    end
  

%-------------------------------------------------------DESACOPLADO
                %     B'    %
     Bp=B;
     n=1           ;
     while n<=z
    if Bus(n)==1
        Bp(n,:)=[];
        Bp(:,n)=[];
    end
    n=n+1;
     end
                 %     B''   %
      Bpp=Bp;
     n=1           ;
     while n<=z
    if Bus(n)==2
        Bpp(n,:)=[];
        Bpp(:,n)=[];
    end
    n=n+1;
     end           
     
   %------------------------- 
        deltaXNdr=[]
        n=1   ;    
        t=1
        v=1;;
    deltaT=-inv(Bp)*deltaPdr
    deltaV=-inv(Bpp)*deltaQdr
    %----------------------------Creaar nuevo vector de estados
    while n<=z
    if(Bus(n)==2)  %PV       
        deltaXNdr=[deltaXNdr ;deltaT(t)];
        t=t+1;
    end
    if(Bus(n)==3)

        deltaXNdr=[deltaXNdr ;deltaT(t) ;deltaV(v)];
        t=t+1;
        v=v+1;
    end
    n=n+1;
    end

    
    x=x+deltaXNdr
    
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
           
   %------------------------------------------------Condición de paro
  D=abs(deltaD)<1E-03  %D=1 cuando se cumple la condición
    a=a+1
        
end 




