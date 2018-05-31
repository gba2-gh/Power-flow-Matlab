function y=tolerance(VT,ite)

    x=size(VT,1);
    n=2;
    m=2;
    z=1;
    
    while n<=x
        re=abs(real(VT(n,ite))-real(VT(n,ite+1)));
        im=abs(imag(VT(n,ite))-imag(VT(n,ite+1)));
        toler(z,1)=re;
        toler(z+1,1)=im;
        n=n+1;
        z=z+2;
    end

y=toler;
end