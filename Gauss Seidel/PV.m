function y=PV(V,Pg,z,nodo,  Ybus,VT)

V2=V;

m=1;
%nodo=2

suma=0;
while m<=z
dato=Ybus(nodo,m)*V(m);
suma=suma+dato;
m=m+1;
end

Qnet=imag(V(nodo)*conj(suma));

suma=suma-Ybus(nodo,nodo)*V(nodo);
Vn=(1/Ybus(nodo,nodo))*((Pg(nodo)-i*Qnet)/conj(V(nodo)) - suma);

Vn=VT(nodo)*(Vn/abs(Vn));

V2(nodo)=Vn;
%abs(V2n)
%end
y=V2;
end

