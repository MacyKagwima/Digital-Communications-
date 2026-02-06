levels_set = [8 16 32 64];

figure;
for k = 1:length(levels_set)

    L = levels_set(k);

    x_min = min(x_sampled);
    x_max = max(x_sampled);
    step  = (x_max - x_min)/L;

    x_q = step * round((x_sampled - x_min)/step) + x_min;
    q_error = x_sampled - x_q;

    subplot(2,2,k)
    stem(n, q_error, 'LineWidth', 1.2)
    title(['Quantization Error, L = ', num2str(L)])
    xlabel('Time (s)')
    ylabel('Error')
    grid on
end
