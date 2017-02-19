function [sequence] = MCRejection_Sampling(func, min_x, max_x, n_bins, n_nums)
%MCREJECTION SAMPLING - random number sampler from a distribution
%func is the pdf function
%min_x - min x to be sampled
%max_x - max x to be samped
%n_bins - no. of bins that aproximate the distribution
%n_nums - n0. of nums to be drawn

f = inline(func);
f = vectorize(f);
x = min_x:0.01:max_x;
y = f(x);
max_y = max(y);
min_y = min(y);
counter = 0;
sequence = [];
area = (max_x - min_x)*(max_y - min_y);

while size(sequence,2) < n_nums
    draw_x = (max_x - min_x)*rand(1, 1) + min_x;
    draw_y = (max_y - min_y)*rand(1, 1) + min_y;
    y_d = f(draw_x);
    counter = counter + 1;
    if (draw_y <= y_d)
        sequence = [sequence draw_x];
    end 
end
estimate = area*n_nums/counter;

figure

subplot(3,1,1)
plot(sequence, f(sequence)./round(estimate), 'g.')
title('Standard function')
xlim([min_x max_x])

subplot(3,1,2)
plot(x, y/estimate)
title('MC sampled function')
xlim([min_x max_x])

subplot(3,1,3)
histogram(sequence, n_bins, 'Normalization', 'pdf')
title('Normalized histogram')
xlim([min_x max_x])


