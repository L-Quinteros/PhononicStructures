function Me=Local_Mass(xm,xa,dens,A,L)
        %Local mass matrix
         Me=(1/6)*(((dens(2)-dens(1))*xm+dens(1))*((A(2)-A(1))*xa+A(1))*L)*[2 0 1 0
                                                                            0 2 0 1
                                                                            1 0 2 0
                                                                            0 1 0 2];
end