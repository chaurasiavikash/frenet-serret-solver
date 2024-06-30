  function fval =   fun_frenet5( var_in)
  
    global k0 kappa  k or s  h N   A   f_t f_b f_n   tau   f_r tx ty tz nx ny nz bx by bz  rx ry rz al w p th B tau1 r nfold 
  
 
 %k0 = var_in(1);
 %var_in = real(var_in);
%  p   = var_in(1);
%  th  = var_in(2);
%  w   = var_in(3);
%  
%  
  
%  [sn,cn,dn] = ellipj(cos(th)*s,p);
%  
%  
%  kp1 = 2*w*cos(th)*sqrt(1-p^2/w^2*sn(1:N/3+1).^2) -  2*w*cos(th)*sqrt(1-p^2/w^2*sn(1).^2);
%  
%  %kappa = [2*w*cos(th)*sqrt(1-p^2/w^2*sn(1:N/3).^2) -2*w*cos(th)*sqrt(1-p^2/w^2*sn(N/3+1:2*N/3).^2) 2*w*cos(th)*sqrt(1-p^2/w^2*sn(2*N/3+1:N+1).^2)];
%  kappa = [kp1 2*kp1(36)-kp1(34:-1:1) kp1];
%  kappa = kappa';
%  
%  

A = var_in(1);
B = var_in(2);
 
 %tau1 = var_in(3);

al1 = 2*A + 2*sqrt(A^2+B);
al2 = 0;
al3 = -2*A +2*sqrt(A^2+B);
 
p = sqrt((al3-al2)/(al3+al1));
q = sqrt(1-al2/al3);
r = 1/2*sqrt(al3+al1);


[K,E] = ellipke(p);
%  s = linspace(0,2*nfold*K/r,N+1);
% %s = linspace(0,1,N+1);
% 
%  tau = tau1*2*nfold*K/r;
%  
%   h = 1/N*2*nfold*K/r;
  
   s = linspace(0,nfold*K/r,N+1);
%s = linspace(0,1,N+1);

 tau = tau1*nfold*K/r;
 
  h = 1/N*nfold*K/r;
  

[sn,cn,dn] = ellipj(r*s,p);


kappa =  sqrt(al3*(1-q^2*sn.^2));


%=== kappa = +- ==== .. Correcting sign of kappa in suitable intervals 
 
% for m = 1:2:nfold-1 
%     
%     kappa((2*m-1)*N/(2*nfold)+1:((2*m-1)*N/(2*nfold) + N/(nfold))) = -kappa((2*m-1)*N/(2*nfold)+1:((2*m-1)*N/(2*nfold) + N/(nfold)));
%     
% end
%     m = nfold;
%     kappa((2*m-1)*N/(2*nfold)+1:N+1) = -kappa((2*m-1)*N/(2*nfold)+1:N+1);
%  kappa = kappa';
%  
 
 kappa(N/10+1:3*N/10)      = -kappa(N/10+1:3*N/10);
 kappa(5*N/10+1:7*N/10) = -kappa(5*N/10+1:7*N/10);
 kappa(9*N/10+1:end)    = - kappa(9*N/10+1:end);
 kappa = kappa';
 
%kappa(236:702,1) = -kappa(236:702,1);
% %--- evaluating at 2nd point using integration 
i = 1;
    rx(i+1,1) = rx(i,1) + h*tx(i,1); 
    ry(i+1,1) = ry(i,1) + h*ty(i,1); 
    rz(i+1,1) = rz(i,1) + h*tz(i,1);
    
    
    tx(i+1,1) = tx(i,1) + kappa(i,1)*h*nx(i,1);
    ty(i+1,1) = ty(i,1) + kappa(i,1)*h*ny(i,1);
    tz(i+1,1) = tz(i,1) + kappa(i,1)*h*nz(i,1);
    
    
    nx(i+1,1) = nx(i,1) + (-kappa(i,1)*tx(i,1) + tau*bx(i,1))*h ;  
    ny(i+1,1) = ny(i,1) + (-kappa(i,1)*ty(i,1) + tau*by(i,1))*h ;  
    nz(i+1,1) = nz(i,1) + (-kappa(i,1)*tz(i,1) + tau*bz(i,1))*h ;  
      
    bx(i+1,1) = bx(i,1) - tau*nx(i,1)*h;
    by(i+1,1) = by(i,1) - tau*ny(i,1)*h;
    bz(i+1,1) = bz(i,1) - tau*nz(i,1)*h;

    

for i = 2:N
    
    rx(i+1,1) = rx(i-1,1) + 2*h*tx(i,1);
    ry(i+1,1) = ry(i-1,1) + 2*h*ty(i,1);
    rz(i+1,1) = rz(i-1,1) + 2*h*tz(i,1);
    
    
    tx(i+1,1) = tx(i-1,1) + kappa(i,1)*2*h*nx(i,1);
    ty(i+1,1) = ty(i-1,1) + kappa(i,1)*2*h*ny(i,1);
    tz(i+1,1) = tz(i-1,1) + kappa(i,1)*2*h*nz(i,1);
    
    
    nx(i+1,1) = nx(i-1,1) + (-kappa(i,1)*tx(i,1) + tau*bx(i,1))*2*h ;  
    ny(i+1,1) = ny(i-1,1) + (-kappa(i,1)*ty(i,1) + tau*by(i,1))*2*h ;  
    nz(i+1,1) = nz(i-1,1) + (-kappa(i,1)*tz(i,1) + tau*bz(i,1))*2*h ;  
      
    bx(i+1,1) = bx(i-1,1) - tau*nx(i,1)*2*h;
    by(i+1,1) = by(i-1,1) - tau*ny(i,1)*2*h;
    bz(i+1,1) = bz(i-1,1) - tau*nz(i,1)*2*h;

end
% for i = 1:N
%     
%     rx(i+1,1) = rx(i,1) + h*tx(i,1);
%     ry(i+1,1) = ry(i,1) + h*ty(i,1);
%     rz(i+1,1) = rz(i,1) + h*tz(i,1);
%     
%     
%     tx(i+1,1) = tx(i,1) + kappa(i,1)*h*nx(i,1);
%     ty(i+1,1) = ty(i,1) + kappa(i,1)*h*ny(i,1);
%     tz(i+1,1) = tz(i,1) + kappa(i,1)*h*nz(i,1);
%     
%     
%     nx(i+1,1) = nx(i,1) + (-kappa(i,1)*tx(i,1) + tau*bx(i,1))*h ;  
%     ny(i+1,1) = ny(i,1) + (-kappa(i,1)*ty(i,1) + tau*by(i,1))*h ;  
%     nz(i+1,1) = nz(i,1) + (-kappa(i,1)*tz(i,1) + tau*bz(i,1))*h ;  
%       
%     bx(i+1,1) = bx(i,1) - tau*nx(i,1)*h;
%     by(i+1,1) = by(i,1) - tau*ny(i,1)*h;
%     bz(i+1,1) = bz(i,1) - tau*nz(i,1)*h;
% 
% end
for i = 2:N+1
    rx(i,1) = rx(i-1,1)+h*tx(i-1,1);
    ry(i,1) = ry(i-1,1)+h*ty(i-1,1);
    rz(i,1) = rz(i-1,1)+h*tz(i-1,1);
end
% r = sqrt(bx.^2+by.^2+bz.^2);
% bx = bx./r;
% by = by./r;
% bz = bz./r;
% 
% r = sqrt(tx.^2+ty.^2+tz.^2);
% tx = tx./r;
% ty = ty./r;
% tz = tz./r;
% 
% r = sqrt(nx.^2+ny.^2+nz.^2);
% nx = nx./r;
% ny = ny./r;
% nz = nz./r;


% 
% f_r = [rx(1)-rx(end) ry(1)-ry(end) rz(1)-rz(end)];
% f_t = [tx(1)-tx(end) ty(1)-ty(end) tz(1)-tz(end)];
% f_n = [nx(1)- or*nx(end) ny(1)- or*ny(end) nz(1)- or*nz(end)];
% f_b = [bx(1)- or*bx(end) by(1)- or*by(end) bz(1)- or*bz(end)];
% 

%  opts = odeset('RelTol',1e-16,'AbsTol',1e-16);
% 
% 
% %s = linspace(0,1,1000); 
% 
% in_rk = [0 -0.1276 0 0.9280 0 -0.3726 0.3726 0 0.9280 0 1 0] ;  % initial point for rk4 integration 
% [t y] = ode45(@fun_rk4, s,in_rk,opts);
% 
% rx = y(:,1);
% ry = y(:,2);
% rz = y(:,3);
% 
% tx = y(:,4);
% ty = y(:,5);
% tz = y(:,6);
% 
% 
% nx = y(:,7);
% ny = y(:,8);
% nz = y(:,9);
% 
% bx = y(:,10);
% by = y(:,11);
% bz = y(:,12);
  
 
f_r = [rx(1)-rx(end) ry(1)-ry(end) rz(1)-rz(end)];
f_t = [tx(1)-tx(end) ty(1)-ty(end) tz(1)-tz(end)];
f_n = [nx(1)- or*nx(end) ny(1)- or*ny(end) nz(1)- or*nz(end)];
f_b = [bx(1)- or*bx(end) by(1)- or*by(end) bz(1)- or*bz(end)];

 % 
% %fval = sqrt(sum(f_r.^2+ f_t.^2 + f_n.^2  ) )
f1 =   sqrt(sum(f_r.^2));
f2 =   sqrt(sum(f_b.^2));
f3 =   sqrt(sum(f_t.^2));
% %f2 =   sqrt(sum(f_b.^2)); 
% 
 fval = [f1 f2] ;
%       
 
% end
 
 