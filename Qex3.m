% Quantization parameters
levels = 16; % Number of quantization levels
x_min = min(x_sampled); % Minimum amplitude
x_max = max(x_sampled); % Maximum amplitude
step = (x_max - x_min)/levels; % Quantization step size


% Uniform quantization
x_quantized = step * round((x_sampled - x_min)/step) + x_min;


% Plot sampled vs quantized signal
figure;
stem(n, x_sampled, 'r', 'LineWidth', 1.5); hold on;
stem(n, x_quantized, 'b--', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude');
title('Sampled Signal vs Quantized Signal');
legend('Sampled Signal', 'Quantized Signal');
grid on;


% Quantization error analysis
quant_error = x_sampled - x_quantized;


figure;
stem(n, quant_error, 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Error');
title('Quantization Error');
grid on;