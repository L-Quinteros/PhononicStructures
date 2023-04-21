function [delta,l1,l2]=obj_pnorm(bands,n,nav,P)
     % Largest value of bands[1:n]
     l1 = Matrixnorm(bands(1:n,:),P);
     %?1 = maximum(bands[1:n,:])

     % Smaller value of bands[n+1,2n]
     l2 = 1.0 / Matrixnorm(1 ./ bands(n+1:nav,:),P);
     %?2 = minimum(bands[n+1:2*n,:])
     delta = l2-l1;
     % The gap
end