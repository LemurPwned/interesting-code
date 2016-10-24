<<<<<<< HEAD
function integral = Monte_Carlo_Integration(func, x_lower, x_upper, y_lower, y_upper, samples)
%Monte Carlo integration - integrates function of two variables using monte
%carlo methods
%x_lower, x_upper - lower and upper bound of dx integral, 
%simmilarly for y_upper and y_lower
%samples- number of samples drawn from the distribution
f = inline(func, 'x','y');
% samples = 50000;
% x_lower = 1;
% x_upper = 4;
% y_lower = 2;
% y_upper = 9;
% e.g f = @(x, y) x.^2 - 2*(y.^2);
f = vectorize(f);
%integrate over region
%linspace allows for using rectancular domain region
x = linspace(x_lower,x_upper,50);
y = linspace(y_lower,y_upper,50);

[xm, ym] = meshgrid(x,y);
zm = f(xm, ym);


%bound the drawing space, is tight, but it does not matter, the likelihood
%of hitting the exact value of function is small
x_upper_limit = max(x);
y_upper_limit = max(y);
x_lower_limit = min(x);
y_lower_limit = min(y);
%this is probably the trickiest part
%remember to take the maximum of a matrix, not the value of 
%uniform field beneath the surface!
z_upper_limit = max(zm(:));
z_lower_limit = min(zm(:));


%now draw pairs (x,y) or triples(x_drawn,y_drawn,z_drawn) to mark a point 
%in space then, check if a function value of e.g z = f(x_drawn,y_drawn) is  
%is greater or less than the remaining coordinate z_drawn
draw_x = (x_upper_limit - x_lower_limit).*rand(1,samples) + x_lower_limit;
draw_y = (y_upper_limit - y_lower_limit).*rand(1,samples) + y_lower_limit;
draw_z = (z_upper_limit - z_lower_limit).*rand(1,samples) + z_lower_limit;


%basically, check if drawn pair (x_drawn,y_drawn) > (x_drawn, f(y_drawn))
%where any pair (x1, y1) > (x2, y2) only if y1>y2;
%no point in checking on the whole array of f(x_original), just 
%validate for f(x_drawn)
new_z = f(draw_x, draw_y);

hit_p = draw_z(draw_z>0 & new_z>0 & new_z>draw_z);
hit_n = draw_z(draw_z<0 & new_z<0 & new_z<draw_z);

%calculate the volume of bounded region 
volume = (x_upper_limit-x_lower_limit)*(y_upper_limit-y_lower_limit)*(z_upper_limit-z_lower_limit);
%how many hit the integrand space? Calculate ratio
cover = (size(hit_p,2) - size(hit_n,2))/size(draw_z,2);
integral = cover*volume;

hit_p_x = draw_x(draw_z>0 & new_z>0 & new_z>draw_z);
hit_n_x = draw_x(draw_z<0 & new_z<0 & new_z<draw_z);

hit_p_y = draw_y(draw_z>0 & new_z>0 & new_z>draw_z);
hit_n_y = draw_y(draw_z<0 & new_z<0 & new_z<draw_z);

%for plotting I need also missed shots
miss_p_x = draw_x(draw_z>0 & new_z<draw_z);
miss_n_x = draw_x(draw_z<0 & new_z>draw_z);

miss_p_y = draw_y(draw_z>0 & new_z<draw_z);
miss_n_y = draw_y(draw_z<0 & new_z>draw_z);

miss_p = draw_z(draw_z>0 &  new_z<draw_z);
miss_n = draw_z(draw_z<0 &  new_z>draw_z);

%plot the above, but transfer original linspace for meshgrid
%it is necessary to use surf
figure
hold on
surf(xm,ym,zm)
scatter3(hit_p_x, hit_p_y, hit_p, 'g.')
scatter3(hit_n_x, hit_n_y, hit_n, 'r.')
scatter3(miss_n_x, miss_n_y, miss_n, 'y.')
scatter3(miss_p_x, miss_p_y, miss_p, 'y.')
hold off
%return
=======
f = @(x, y) x.^3 - 2*(y);
%integrate over region
%linspace allows for using rectancular domain region
x = linspace(1,4,50);
y = linspace(2,9,50);
z = f(x,y);
[xm, ym] = meshgrid(x,y);
zm = xm.^3 - 2*ym;

%bound the drawing space, is tight, but it does not matter, the likelihood
%of hitting the exact value of function is small
x_upper_limit = max(x);
y_upper_limit = max(y);
x_lower_limit = min(x);
y_lower_limit = min(y);
%this is probably the trickiest part
%remember to take the maximum of a matrix, not the value of 
%uniform field beneath the surface!
z_upper_limit = max(zm(:));
z_lower_limit = min(zm(:));


%now draw pairs (x,y) or triples(x_drawn,y_drawn,z_drawn) to mark a point 
%in space then, check if a function value of e.g z = f(x_drawn,y_drawn) is  
%is greater or less than the remaining coordinate z_drawn
draw_x = (x_upper_limit - x_lower_limit).*rand(1,500000) + x_lower_limit;
draw_y = (y_upper_limit - y_lower_limit).*rand(1,500000) + y_lower_limit;
draw_z = (z_upper_limit - z_lower_limit).*rand(1,500000) + z_lower_limit;


%basically, check if drawn pair (x_drawn,y_drawn) > (x_drawn, f(y_drawn))
%where any pair (x1, y1) > (x2, y2) only if y1>y2;
%no point in checking on the whole array of f(x_original), just 
%validate for f(x_drawn)
new_z = f(draw_x, draw_y);
hit_p = draw_z(draw_z>0 & new_z>0 & new_z>draw_z);
hit_n = draw_z(draw_z<0 & new_z<0 & new_z<draw_z);

%calculate the volume of bounded region 
volume = (x_upper_limit-x_lower_limit)*(y_upper_limit-y_lower_limit)*(z_upper_limit-z_lower_limit);
%how many hit the integrand space? Calculate ratio
cover = (size(hit_p,2) - size(hit_n,2))/size(draw_z,2);
integral = cover*volume

hit_p_x = draw_x(draw_z>0 & new_z>0 & new_z>draw_z);
hit_n_x = draw_x(draw_z<0 & new_z<0 & new_z<draw_z);

hit_p_y = draw_y(draw_z>0 & new_z>0 & new_z>draw_z);
hit_n_y = draw_y(draw_z<0 & new_z<0 & new_z<draw_z);

%for plotting I need also missed shots
miss_p_x = draw_x(draw_z>0 & new_z<draw_z);
miss_n_x = draw_x(draw_z<0 & new_z>draw_z);

miss_p_y = draw_y(draw_z>0 & new_z<draw_z);
miss_n_y = draw_y(draw_z<0 & new_z>draw_z);

miss_p = draw_z(draw_z>0 &  new_z<draw_z);
miss_n = draw_z(draw_z<0 &  new_z>draw_z);

%plot the above, but transfer original linspace for meshgrid
%it is necessary to use surf
figure
hold on
surf(xm,ym,zm)
scatter3(hit_p_x, hit_p_y, hit_p, 'g.')
scatter3(hit_n_x, hit_n_y, hit_n, 'r.')
scatter3(miss_n_x, miss_n_y, miss_n, 'y.')
scatter3(miss_p_x, miss_p_y, miss_p, 'y.')
hold off
>>>>>>> parent of 93b0567... Turned into function
