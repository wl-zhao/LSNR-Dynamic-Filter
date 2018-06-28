function []=stem_plot(x, y)
plot_range = 1 : 100;
stem(x(plot_range), y(plot_range), 'filled', 'MarkerSize', 3);
end