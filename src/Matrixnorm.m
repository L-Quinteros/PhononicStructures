function Anorm = Matrixnorm(A,p)
    v_A = zeros(length(A(1,:)),1);
    for i =1:length(A(1,:))
        v_A(i) = norm(A(:,i),p); 
    end 
    Anorm = norm(v_A,p);
end 