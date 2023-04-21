function [thetax,thetay]=wave_vector(NINT,Lx,Ly)
    %If minv=0, the matrix becomes singular, so in order to avoid numerical
    % problems a relative close number to 0 is chosen.
    Minv=1e-4;
    thetax1=linspace(Minv/(Lx),(pi/(Lx)), NINT); 
    thetax3=linspace((pi/(Lx)),Minv/(Lx), NINT); 
    thetay2=linspace(Minv/(Ly),(pi/Ly),NINT);
    thetay3=linspace((pi/Ly),Minv/(Ly),NINT);
    thetax = [thetax1 (pi/(Lx))*ones(NINT,1)' thetax3];
    thetay = [(Minv/(Ly))*ones(NINT,1)' thetay2 thetay3];
end   