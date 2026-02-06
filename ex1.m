clear; close all; clc;


% Signal parameters
tot = 1; % Total duration (s)
td = 0.002; % Time resolution (s)
t = 0:td:tot; % Time vector


% Message signal (1 Hz and 3 Hz components)
x = sin(2*pi*1*t) - sin(2*pi*3*t);


% Time-domain plot
figure;
plot(t, x, 'LineWidth', 2);
xlabel('Time (s)'); ylabel('Amplitude');
title('Input Message Signal');
grid on;


% Frequency-domain analysis
L = length(x);
Lfft = 2^nextpow2(L);
fmax = 1/(2*td);
faxis = linspace(-fmax, fmax, Lfft);


Xfft = fftshift(fft(x, Lfft));


figure;
plot(faxis, abs(Xfft));
xlabel('Frequency (Hz)'); ylabel('Magnitude');
title('Spectrum of Input Message Signal');
grid on;


% Sampling
Ts = 0.02; % Sampling period (s)
n = 0:Ts:tot; % Sampled time vector
x_sampled = sin(2*pi*1*n) - sin(2*pi*3*n);


figure;
stem(n, x_sampled, 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude');
title('Sampled Signal');
grid on;


% Upsampling for spectral observation
Nfactor = round(Ts/td);
x_up = upsample(x_sampled, Nfactor);


Lffu = 2^nextpow2(length(x_up));
faxisu = linspace(-fmax, fmax, Lffu);
Xfftu = fftshift(fft(x_up, Lffu));


figure;
plot(faxisu, abs(Xfftu));
xlabel('Frequency (Hz)'); ylabel('Magnitude');
title('Spectrum of Sampled Signal');
grid on;