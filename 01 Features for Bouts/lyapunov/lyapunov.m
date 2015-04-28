function exponent = lyapunov(x)
% calculate lyapunov coefficient of time series

ndata =size(x, 1);

N2 = floor(ndata/2);
N4 = floor(ndata/4);
TOL = 1.0e-6;

exponent = zeros(N4+1,1);

for i=N4:N2  % second quartile of data should be sufficiently evolved
   dist = norm(x(i+1,:)-x(i,:));
   indx = i+1;
   for j=1:ndata-5
       if (i ~= j) && norm(x(i,:)-x(j,:))<dist
           dist = norm(x(i,:)-x(j,:));
           indx = j; % closest point!
       end
   end
   expn = 0.0; % estimate local rate of expansion (i.e. largest eigenvalue)
   for k=1:5
       if norm(x(i+k,:)-x(indx+k,:))>TOL && norm(x(i,:)-x(indx,:))>TOL
           expn = expn + (log(norm(x(i+k,:)-x(indx+k,:)))-log(norm(x(i,:)-x(indx,:))))/k;
       end
   end
   exponent(i-N4+1)=expn/5;
end