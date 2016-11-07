function [new_x_t, new_y_t] = conjugate_grad(func_in, x_in, y_in)
%set that up
min_x = -5;
min_y = min_x;
max_x = 5;
max_y = max_x;

syms x y

gradx(x,y) = diff(func_in(x,y), x);
grady(x,y) = diff(func_in(x,y), y);

old_x = x_in;
old_y = y_in;

%ugghh .. litle bit messy
learning_rate = 0.05;
new_x = old_x;
new_y = old_y;

new_x_t = new_x;
new_y_t = new_y;

for i = 1:500
    t_x = gradx(new_x_t(end), new_y_t(end));
    t_y = grady(new_x_t(end), new_y_t(end));
    if i>1
        g_x = t_x + (t_x)^2/(double(gradx(new_x_t(end-1), new_y_t(end-1))));
        g_y = t_y + (t_y)^2/(double(grady(new_x_t(end-1), new_y_t(end-1))));
    else
        g_x = t_x;
        g_y = t_y;
    end
    if abs(g_x) < 0.00001 && abs(g_y) < 0.00001
        break
    end    
    new_x = new_x - learning_rate *double(g_x);
    new_y = new_y - learning_rate *double(g_y);
    if new_x > max_x || new_x < min_x || new_y > max_y || new_y < min_y
        break
    end
    %redundant but it's what I like
    new_x_t = [new_x_t new_x];
    new_y_t = [new_y_t new_y];

    old_x = new_x;
    old_y = new_y;

end
end