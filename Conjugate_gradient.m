%Ax = b
%A is positive, definite, symmetric
%solution x is also minimizer to an equation
%(1/2)*x'Ax = x'b
%first guess, if not biased, always x0 = 0
%this means p0 = b - Ax0
%residual at kth step is rk = b - Axk
%rk is the negative gradient of f at x = xk
%so the gradient descent moves in direction rk
% pk = rk - sum_(i<k)_[(pi'*A*rk)/(pi'*A*pi)]
%following this step xk+1 = xk + alpha*pk
%alpha is [pk'*b/pk'*A*pk]
%first iteration
A = [ 3,2; 2,6];
b = [2; -8];
x_old = [5; 3];
% n = 5;
% A = rand(5)*10;
% b = rand(2,1);
% x_old = zeros(n,1);
r_old = b - A*x_old;
p_old = r_old;

% % 
% % %up to here all is set up by user
% % x0 = [2; 1];
% % r0 = b - A*x0;
% % p0 = r0;
% % alpha = (r0'*r0)/(p0'*A*p0);
% % x1 = x0 + alpha*p0;
% % 
% % %second
% % r1 = r0 - alpha*A*p0;
% % beta = (r1'*r1)/(r0'*r0);
% % p1 = r1 + beta*p0;
% % alpha = (r1'*r1)/(p1'*A*p1);
% % x2 = x1 + alpha*p1;


for i = 1:10
    alpha = (r_old(:,end)'*r_old(:, end))/(p_old'*A*p_old);
    x_new = x_old(:,end) + alpha*p_old;
    r_new = r_old(:,end) - alpha*A*p_old;
    if sqrt(r_new) < 0.00001
        x_old = [x_old x_new];
        break;
    end
    beta = (r_new'*r_new)/(r_old(:,end)'*r_old(:,end));
    p_new = r_new + beta*p_old;
    p_old = p_new;
%     r_old = r_new;
%     x_old = x_new;
    r_old = [r_old r_new];
    x_old = [x_old x_new];
    %alpha = (r_new'*r_new)/(p_new'*A*p_new)
end

%for plot
x1 = linspace(-4,6,100);
x2 = linspace(-6,4,100);
[x1m, x2m] = meshgrid(x1, x2);
zm = zeros(100);
% A = [ 3,2; 2,6];
% b = [2; -8];
for i = 1:100
    for j = 1:100
        x = [x1m(i,j); x2m(i,j)];
        f = x'*A*x - b'*x;
        zm(i,j) = f;
    end
end
contourf(x1m, x2m, zm)
hold on
xx = x_old(1,:);
yy = x_old(2,:);
plot(xx, yy ,'r.-')
hold off
