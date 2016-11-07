function [new_x_t, new_y_t] = Basic_grad(func_in, x_in, y_in)
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
    if abs(double(gradx(old_x, old_y))) < 0.001 && abs(double(grady(old_x, old_y))) < 0.001
        break
    end    
    new_x = new_x - learning_rate *double(gradx(old_x, old_y));
    new_y = new_y - learning_rate *double(grady(old_x, old_y));
    if new_x > max_x || new_x < min_x || new_y > max_y || new_y < min_y
        break
    end
    %redundant but it's what I like
    new_x_t = [new_x_t new_x];
    new_y_t = [new_y_t new_y];

    old_x = new_x;
    old_y = new_y;

end
%hold off
%return