function [aprox] = Taylor(func, x0, n_it)
    %Taylor series
    syms f(x) taylor(x) x
    f(x) = func(x);
    taylor(x) = f(x0);
    aprox = [];
    aprox = [aprox f(x0)];
    %f(x0) + f'(x0)*(x-x0) + f''(x0)*(x-x0)^2/2! etc...
    for k=1:n_it
         nth_dev(x) = diff(f(x),x);
         f(x) = nth_dev;
         fc = 1/factorial(k);
         taylor(x) = taylor(x) + f(x0)*((x - x0)^k)*fc;
         aprox = [aprox taylor(x)];
    end
end


