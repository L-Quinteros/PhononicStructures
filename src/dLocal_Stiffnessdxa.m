function dkedxa = dLocal_Stiffnessdxa(xm,xa,E,A,L)

         dkedxa=(((E(2)-E(1))*xm+E(1))*((A(2)-A(1)))/L)*[1.0 0.0 -1.0  0.0
                                                         0.0 0.0  0.0  0.0
                                                         -1.0 0.0  1.0  0.0
                                                          0.0 0.0  0.0  0.0];
end