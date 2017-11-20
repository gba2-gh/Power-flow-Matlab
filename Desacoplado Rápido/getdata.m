function y=getdata(Dato,z,y)
dat=size(Dato,1);
M=zeros(4)
i=1;
while i<=dat
    a=Dato(i,1);

    b = Dato(i,2);
    if Dato(i,z) == 0
        if Dato(i,y) == 0
            M(a,b)=0;
        else
             M(a,b)= 1/Dato(i,y)*j;
        end
    else
        if Dato(i,y) == 0
        M(a,b)= 1/Dato(i,z);
        else
        M(a,b)= 1/(Dato(i,z) + Dato(i,y)*j) ;
        end
    end
    i=i+1;
end

y=M;
end

