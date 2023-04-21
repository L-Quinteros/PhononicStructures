function [xopt,fmin]=opt_gcmma(f,dfdx,x0)
%%%% If outeriter=0, the user should now calculate function values
%%%% and gradients of the objective- and constraint functions at xval.
%%%% The results should be put in f0val, df0dx, fval and dfdx:
m = 2;
n = 3;
epsimin = 0.0000001;
xval    = [4 3 2]';
xold1   = xval;
xold2   = xval;
xmin    = [0  0  0]';
xmax    = [5  5  5]';
low     = xmin;
upp     = xmax;
c       = [1000  1000]';
d       = [1  1]';
a0      = 1;
a       = [0  0]';;
raa0    = 0.01;
raa     = 0.01*[1  1]';
raa0eps = 0.000001;
raaeps  = 0.000001*[1  1]';
outeriter = 0;
maxoutit  = 1;
kkttol  = 0;
%
if outeriter < 0.5
  [f0val,df0dx,fval,dfdx] = toy2(xval);
  innerit=0;
  outvector1 = [outeriter innerit xval']
  outvector2 = [f0val fval']
end
%
%%%% The outer iterations start:
kktnorm = kkttol+10;
outit = 0;
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
  [f0valnew,fvalnew] = toy1(xmma);
%%%% It is checked if the approximations are conservative:
  [conserv] = concheck(m,epsimin,f0app,f0valnew,fapp,fvalnew);
%%%% While the approximations are non-conservative (conserv=0),
%%%% repeated inner iterations are made:
  innerit=0;
  if conserv == 0
    while conserv == 0 & innerit <= 15
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
      [f0valnew,fvalnew] = toy1(xmma);
%%%% It is checked if the approximations have become conservative:
      [conserv] = concheck(m,epsimin,f0app,f0valnew,fapp,fvalnew);
    end
  end
%%%% No more inner iterations. Some vectors are updated:
  xold2 = xold1;
  xold1 = xval;
  xval  = xmma;
%%%% The user should now calculate function values and gradients
%%%% of the objective- and constraint functions at xval.
%%%% The results should be put in f0val, df0dx, fval and dfdx:
  [f0val,df0dx,fval,dfdx] = toy2(xval);
%%%% The residual vector of the KKT conditions is calculated:
  [residu,kktnorm,residumax] = ...
  kktcheck(m,n,xmma,ymma,zmma,lam,xsi,eta,mu,zet,s, ...
           xmin,xmax,df0dx,fval,dfdx,a0,a,c,d);
  outvector1 = [outeriter innerit xval']
  outvector2 = [f0val fval']
end
%-----------------



end 