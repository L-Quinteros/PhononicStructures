function dmedxa=dLocal_Massdxa(xm,xa,dens,A,L)
         dmedxa=(1/6)*(((dens(2)-dens(1))*xm+dens(1))*((A(2)-A(1)))*L)*[2.0 0.0 1.0 0.0
                                                                        0.0 2.0 0.0 1.0
                                                                        1.0 0.0 2.0 0.0
                                                                        0.0 1.0 0.0 2.0]; 
end