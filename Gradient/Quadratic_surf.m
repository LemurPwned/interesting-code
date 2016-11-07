function [x_old] = Quadratic_surf(matrix, b, x_in, y_in)
A = matrix;

%pick a point
%messy stuff, better look at my version on github 
%please refer here : https://github.com/LemurPwned/interesting_code/blob/master/Conjugate_gradient.m
%standard MIT license

x_old = [x_in; y_in];
r_old = b - A*x_old;
p_old = r_old;
for i = 1:10
    alpha = (r_old(:,end)'*r_old(:, end))/(p_old'*A*p_old);
    x_new = x_old(:,end) + alpha*p_old;
    r_new = r_old(:,end) - alpha*A*p_old;
    if sqrt(r_new) < 0.00001 
        x_old = [x_old x_new];
        break;
    end
    if x_new(1,1) > 6 || x_new(1,1) < -4 || x_new(2,1) > 4 || x_new(2,1) < -6 
        break;
    end
    beta = (r_new'*r_new)/(r_old(:,end)'*r_old(:,end));
    p_new = r_new + beta*p_old;
    p_old = p_new;
    r_old = [r_old r_new];
    x_old = [x_old x_new];
    
end



