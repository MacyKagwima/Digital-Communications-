clear; close all; clc;


% Signal parameters
tot = 1;
td = 0.002;
t = 0:td:tot;


x = sin(2*pi*1*t) - sin(2*pi*3*t);


% Sampling parameters
Ts = 0.02;
Nfactor = round(Ts/td);


% Sampling and upsampling
x_sm = downsample(x, Nfactor);
x_smu = upsample(x_sm, Nfactor);


% Frequency-domain representation
Lffu = 2^nextpow2(length(x_smu));
fmax = 1/(2*td);
faxis = linspace(-fmax, fmax, Lffu);


Xfftu = fftshift(fft(x_smu, Lffu));


figure;
plot(faxis, abs(Xfftu));
xlabel('Frequency (Hz)'); ylabel('Magnitude');
title('Spectrum of Sampled Signal');
grid on;


% Ideal Low Pass Filter design
BW = 10; % Bandwidth (Hz)
H_lpf = zeros(1, Lffu);
H_lpf(Lffu/2-BW : Lffu/2+BW-1) = 1;


figure;
plot(faxis, H_lpf);
xlabel('Frequency (Hz)'); ylabel('Amplitude');
title('Transfer Function of LPF');
grid on;


% Apply LPF and reconstruct
X_recv = Nfactor * Xfftu .* H_lpf;


figure;
plot(faxis, abs(X_recv));
xlabel('Frequency (Hz)'); ylabel('Magnitude');
title('Spectrum of LPF Output');
grid on;


x_rec = real(ifft(fftshift(X_recv)));
x_rec = x_rec(1:length(t));


figure;
plot(t, x, 'r', t, x_rec, 'b--', 'LineWidth', 2);
xlabel('Time (s)'); ylabel('Amplitude');
title('Original vs Reconstructed Signal');
legend('Original Signal', 'Reconstructed Signal');
grid on;