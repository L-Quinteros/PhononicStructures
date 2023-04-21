function dmedxm=dLocal_Massdxm(xm,xa,dens,A,L)
         dmedxm=(1/6)*(((dens(2)-dens(1)))*((A(2)-A(1))*xa+A(1))*L)*[2.0 0.0 1.0 0.0
                                                                    0.0 2.0 0.0 1.0
                                                                    1.0 0.0 2.0 0.0
                                                                    0.0 1.0 0.0 2.0];
end