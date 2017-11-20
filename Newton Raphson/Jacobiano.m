function y=Jacobiano(deltaX, G, B, V, P, Q, teta,z,Bus)
J=[];
 Jfila=[];
      n=1;  
      w=1;
      f=size(deltaX,1);
    while n<=z
    if(Bus(n)==2)%----------------------Para PV
        while w<=f
        if(deltaX(w)==1)
            if(deltaX(w,2)==n)
                deriv=-Q(n)-B(n,n)*(V(n)^2)
               Jfila=[Jfila deriv];
            else
                m=deltaX(w,2);
                 deriv=V(n)*V(m)*(G(n,m)*sin(teta(n)-teta(m))-B(n,m)*cos(teta(n)-teta(m)))
                 Jfila=[Jfila deriv];
            end    
        end
        if(deltaX(w)==2)
            if(deltaX(w,2)==n)
            deriv=P(n)+G(n,n)*V(n)^2;
            deriv=deriv/V(n)
            Jfila=[Jfila deriv];
            
            else
              m=deltaX(w,2);
                 deriv=V(n)*V(m)*(G(n,m)*cos(teta(n)-teta(m))+B(n,m)*sin(teta(n)-teta(m)));
                 deriv=deriv/V(m)
                 Jfila=[Jfila deriv];
            end      
        end
        w=w+1;
       
        end
         w=1;
    end
    
    J=[J ;Jfila];
     Jfila=[];
    if(Bus(n)==3)%---------------------------Para PQ
        
        %-----Con P
        while w<=f
        if(deltaX(w)==1)
            if(deltaX(w,2)==n)
                deriv=-Q(n)-B(n,n)*(V(n)^2)
                Jfila=[Jfila deriv];
            else
                m=deltaX(w,2);
                 deriv=V(n)*V(m)*(G(n,m)*sin(teta(n)-teta(m))-B(n,m)*cos(teta(n)-teta(m)))
                 Jfila=[Jfila deriv];
                 
            end    
        end
        if(deltaX(w)==2)
            if(deltaX(w,2)==n)
            deriv=P(n)+G(n,n)*V(n)^2;
            deriv=deriv/V(n)
            Jfila=[Jfila deriv];
            else
              m=deltaX(w,2);
                 deriv=V(n)*V(m)*(G(n,m)*cos(teta(n)-teta(m))+B(n,m)*sin(teta(n)-teta(m)));
                 deriv=deriv/V(m)
                 Jfila=[Jfila deriv];
            end      
        end
        w=w+1;
        
        end
         w=1;
        J=[J ;Jfila];
         Jfila=[];
         %-----con Q
          while w<=f
        if(deltaX(w)==1)
            if(deltaX(w,2)==n)
                deriv=P(n)-G(n,n)*V(n)^2
                Jfila=[Jfila deriv];
            else
                m=deltaX(w,2);
                 deriv=-V(n)*V(m)*(G(n,m)*cos(teta(n)-teta(m))+B(n,m)*sin(teta(n)-teta(m)))
                 Jfila=[Jfila deriv];
                 
            end    
        end
        if(deltaX(w)==2)
            if(deltaX(w,2)==n)
            deriv=Q(n)-B(n,n)*V(n)^2;
            deriv=deriv/V(n)
            Jfila=[Jfila deriv];
            else
              m=deltaX(w,2);
                 deriv=-V(n)*V(m)*(G(n,m)*sin(teta(n)-teta(m))-B(n,m)*cos(teta(n)-teta(m)));
                 deriv=deriv/V(m);
                 Jfila=[Jfila deriv];
            end      
        end
        w=w+1;
      
          end
     J=[J ;Jfila]
      Jfila=[];
    end
   
    n=n+1;
    end
    
y=J
end