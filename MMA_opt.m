function [x_opt,f_opt]=MMA_opt(f0,df0,f,df,xval,xmin,xmax,niter)

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
    
    if outeriter < 0.5
      f0val = f0(xval);
      df0dx = df0(xval);
      fval = f(xval);
      dfdx = df(xval);
      
      innerit=0;
      %outvector1 = [outeriter innerit xval'];
      %outvector2 = [f0val fval'];
    end
    %
    %%%% The iterations start:
    low     = xmin;
    upp     = xmax;
    xold1   = xval;
    xold2   = xval;
    kkttol  = 0;
    kktnorm = kkttol+10;
    maxoutit = niter;
    outit = 0;
    while kktnorm > kkttol & outit < maxoutit
      outit   = outit+1;
      outeriter = outeriter+1;
     
    %%%% The MMA subproblem is solved at the point xval:
      [xmma,ymma,zmma,lam,xsi,eta,mu,zet,s,low,upp] = ...
      mmasub(m,n,outeriter,xval,xmin,xmax,xold1,xold2, ...
      f0val,df0dx,fval,dfdx,low,upp,a0,a,c,d);
    
    %%%% Some vectors are updated:
      xold2 = xold1;
      xold1 = xval;
      xval  = xmma;
    %%%% The user should now calculate function values and gradients
    %%%% of the objective- and constraint functions at xval.
    %%%% The results should be put in f0val, df0dx, fval and dfdx.
      f0val = f0(xval);
      df0dx = df0(xval);
      fval = f(xval);
      dfdx = df(xval);
    %%%% The residual vector of the KKT conditions is calculated:
      [~,kktnorm,~] = ...
      kktcheck(m,n,xmma,ymma,zmma,lam,xsi,eta,mu,zet,s, ...
               xmin,xmax,df0dx,fval,dfdx,a0,a,c,d);
      %outvector1 = [outeriter xval']
      %outvector2 = [f0val fval']
      f_opt(outeriter,1)= f0val; 
      
     fprintf(['Iteration %i, feval = %i \n'],outeriter,f0val) 
    %
    end
    %---------------------------------------------------------------------
    x_opt = xval;
    
    %f_opt = f0val;
    
end 

