function y=getdataADM(Dato,z,y)

%Dato = xlsread('Ybus.xlsx')

%z=3;
%y=4;
%g=5;
%b=6;

dat=size(Dato,1);
M=[];
i=1;
while i<=dat
    a=Dato(i,1);

    b = Dato(i,2);
    if Dato(i,z) == 0
        if Dato(i,y) == 0
            M(a,b)=0;
        else
             M(a,b)= Dato(i,y)*j;
        end
    else
        if Dato(i,y) == 0
        M(a,b)= Dato(i,z);
        else
        M(a,b)= (Dato(i,z) + Dato(i,y)*j) ;
        end
    end
    i=i+1;
end

y=M;

end