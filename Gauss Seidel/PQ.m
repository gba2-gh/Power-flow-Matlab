function y=PQ(V,Pd,Qd,z,nodo,  Ybus)
%Ybus=[2-20i -1+10i -1+10i ; -1+10i 2-20i -1+10i; -1+10i -1+10i 2-20i]
              
                V2=V;
                
m=1;
%nodo=3

suma=0;
while m<=z
dato=Ybus(nodo,m)*V(m);
suma=suma+dato;
m=m+1;
end

suma=suma-Ybus(nodo,nodo)*V(nodo);

Vn=(1/Ybus(nodo,nodo))*((Pd(nodo)-i*Qd(nodo))/conj(V(nodo)) - suma);

%Vn=V(nodo)*(Vn/abs(Vn))

V2(nodo)=Vn;
%abs(V2n)
%end
y=V2;

end