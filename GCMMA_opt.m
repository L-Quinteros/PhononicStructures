function [x_opt,f_opt,ninner]=GCMMA_opt(f0,df0,f,df,xval,xmin,xmax,niter)
    
    m = length(f(xval));
    n = length(xval);
    %xval    = [4 3 2]';
    
    %xmin    = [0  0  0]';
    %xmax    = [5  5  5]';
    c       = 1000*ones(m,1);
    d       = ones(m,1);
    a0      = 1;
    a       = zeros(m,1);
    outeriter = 0;
    f_opt = zeros(niter,1);
    ninner = zeros(niter,1);
    
    if outeriter < 0.5
      f0val = f0(xval);
      df0dx = df0(xval);
      fval = f(xval);
      dfdx = df(xval);
      
      innerit=0;
      outvector1 = [outeriter innerit xval'];
      outvector2 = [f0val fval'];
    end
    %
    %%%% The iterations start:
    raa0    = 0.01;
    raa     = 0.01*ones(m,1);
    raa0eps = 0.000001;
    raaeps  = 0.000001*ones(m,1);
    low     = xmin;
    upp     = xmax;
    xold1   = xval;
    xold2   = xval;
    kkttol  = 0;
    epsimin = 0.0000001;
    kktnorm = kkttol+10;
    maxoutit = niter;
    outit = 0;
    %%%% The outer iterations start:
    while kktnorm > kkttol & outit < maxoutit
      outit   = outit+1;
      outeriter = outeriter+1;
    %%%% The parameters low, upp, raa0 and raa are calculated:  
      [low,upp,raa0,raa] = ...
      asymp(outeriter,n,xval,xold1,xold2,xmin,xmax,low,upp, ...
            raa0,raa,raa0eps,raaeps,df0dx,dfdx);
    
    %%%% The GCMMA subproblem is solved at the point xval:
      [xmma,ymma,zmma,lam,xsi,eta,mu,zet,s,f0app,fapp] = ...
      gcmmasub(m,n,outeriter,epsimin,xval,xmin,xmax,low,upp, ...
               raa0,raa,f0val,df0dx,fval,dfdx,a0,a,c,d);
           
    %%%% The user should now calculate function values (no gradients)
    %%%% of the objective- and constraint functions at the point xmma
    %%%% ( = the optimal solution of the subproblem).
    %%%% The results should be put in f0valnew and fvalnew.
      f0valnew = f0(xmma);
      fvalnew = f(xmma);
    %%%% It is checked if the approximations are conservative:
      [conserv] = concheck(m,epsimin,f0app,f0valnew,fapp,fvalnew);
    %%%% While the approximations are non-conservative (conserv=0),
    %%%% repeated inner iterations are made:
      innerit=0;
      if conserv == 0
        while conserv == 0 & innerit < 15
          innerit = innerit+1;
    %%%% New values on the parameters raa0 and raa are calculated:
          [raa0,raa] = ...
          raaupdate(xmma,xval,xmin,xmax,low,upp,f0valnew,fvalnew, ...
                    f0app,fapp,raa0,raa,raa0eps,raaeps,epsimin);
    %%%% The GCMMA subproblem is solved with these new raa0 and raa:
          [xmma,ymma,zmma,lam,xsi,eta,mu,zet,s,f0app,fapp] = ...
          gcmmasub(m,n,outeriter,epsimin,xval,xmin,xmax,low,upp, ...
                   raa0,raa,f0val,df0dx,fval,dfdx,a0,a,c,d);
    %%%% The user should now calculate function values (no gradients)
    %%%% of the objective- and constraint functions at the point xmma
    %%%% ( = the optimal solution of the subproblem).
    %%%% The results should be put in f0valnew and fvalnew:
           f0valnew = f0(xmma);
           fvalnew = f(xmma);
    %%%% It is checked if the approximations have become conservative:
          [conserv] = concheck(m,epsimin,f0app,f0valnew,fapp,fvalnew);
          ninner(outeriter,1)=innerit;
        end
        
      end
    %%%% No more inner iterations. Some vectors are updated:
      xold2 = xold1;
      xold1 = xval;
      xval  = xmma;
    %%%% The user should now calculate function values and gradients
    %%%% of the objective- and constraint functions at xval.
    %%%% The results should be put in f0val, df0dx, fval and dfdx:
      f0val = f0(xval);
      df0dx = df0(xval);
      fval = f(xval);
      dfdx = df(xval);

    %%%% The residual vector of the KKT conditions is calculated:
      [~,kktnorm,~] = ...
      kktcheck(m,n,xmma,ymma,zmma,lam,xsi,eta,mu,zet,s, ...
               xmin,xmax,df0dx,fval,dfdx,a0,a,c,d);
      
      fprintf(['Iteration %i, feval = %i \n'],outeriter,f0val);
      f_opt(outeriter,1)= f0val;  
     % if outeriter>3
      %    if abs(f_opt(outeriter-2)-f_opt(outeriter-1))<1e-6 && abs(f_opt(outeriter-1)-f_opt(outeriter))<1e-6
      %      break
      %    end  
      %end 
      
    end
    %---------------------------------------------------------------------
    x_opt = xval;
    %f_opt = f0val;
end 
