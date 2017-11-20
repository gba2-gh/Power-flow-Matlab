function y=MatrizAdmitanciasNodales

Dato = xlsread('Ybus.xlsx');

r=3;
x=4;
g=5;
b=6;

M=getdataADM(Dato,r,x);
%M2=getdata(Dato,x);




M2=getdataADM(Dato,g,b);
M2=M2/2;

M=M+M2;


U=triu(M);

%[n,m]=size(U);
UT=U';

B=conj(UT)+U;

%B(1:n+1:end)=diag(U)
diago=diag(B);
D=diag(diago);
B=B-D;

s=sum(M,2);
s=s*1;
D=diag(s);

Y=-B+D;

y=Y;

end

