function dkedxm=dLocal_Stiffnessdxm(xm,xa,E,A,L)
         dkedxm=(((E(2)-E(1)))*((A(2)-A(1))*xa+A(1))/L)*[1.0 0.0 -1.0  0.0
                                                              0.0 0.0  0.0  0.0
                                                             -1.0 0.0  1.0  0.0
                                                              0.0 0.0  0.0, 0.0 ];
end