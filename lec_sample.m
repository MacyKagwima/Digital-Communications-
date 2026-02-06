%Sampling & reconctruction lec code

clear all;
close all;
clc;
tot = 1;
td = 0.002;
t = 0:td:tot;
x = sin(2*pi*t) - sin(6*pi*t);
figure;
plot(t, x, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Input Message Signal');
grid on;
L = length(x);
Lfft = 2^nextpow2(L);
fmax = 1/(2*td);
Faxis = linspace(-fmax, fmax, Lfft);
Xfft = fftshift(fft(x, Lfft));
figure;
plot(Faxis, abs(Xfft));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Spectrum of Input Message Signal');
grid on;
ts = 0.02;
n = 0:ts:tot;
x_sampled = sin(2*pi*n) - sin(6*pi*n);
figure;
stem(n, x_sampled, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Sampled Signal');
grid on;
x_sampled_upsampled = upsample(x_sampled, round(ts/td));
Lffu = 2^nextpow2(length(x_sampled_upsampled));
fmaxu = 1/(2*td);
Faxisu = linspace(-fmaxu, fmaxu, Lffu);
Xfftu = fftshift(fft(x_sampled_upsampled, Lffu));
figure;

3

plot(Faxisu, abs(Xfftu));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Spectrum of Sampled Signal');
grid on;
MATLAB Code for Experiment 2: Reconstruction
from Sampled Signal
clear all;
close all;
clc;
tot=1;
td=0.002;
t=0:td:tot;
x=sin(2*pi*t)-sin(6*pi*t);
ts=0.02;
Nfactor=round(ts/td);
xsm=downsample(x,Nfactor);
xsmu=upsample(xsm,Nfactor);
Lffu=2^nextpow2(length(xsmu));
fmaxu=1/(2*td);
Faxisu=linspace(-fmaxu,fmaxu,Lffu);
xfftu=fftshift(fft(xsmu,Lffu));
figure(1);
plot(Faxisu,abs(xfftu));
xlabel('Frequency');
ylabel('Amplitude');
title('Spectrum of Sampled Signal');
grid;
BW=10;
H_lpf=zeros(1,Lffu);
H_lpf(Lffu/2-BW:Lffu/2+BW-1)=1;
figure(2);
plot(Faxisu,H_lpf);
xlabel('Frequency');
ylabel('Amplitude');
title('Transfer function of LPF');
grid;
x_recv=Nfactor*((xfftu)).*H_lpf;
4

figure(3)
plot(Faxisu,abs(x_recv));
xlabel('Frequency');
ylabel('Amplitude');
title('Spectrum of LPF Output');
grid;
x_recv1=real(ifft(fftshift(x_recv)));
x_recv2=x_recv1(1:length(t));
figure(4)
plot(t,x,'r',t,x_recv2,'b--','LineWidth',2);
xlabel('Time');
ylabel('Amplitude');
title('Original vs. Reconstructed Signal');
grid;


%Quantization lec code

% Define quantization levels
levels = 16;
x_min = min(x_sampled);
x_max = max(x_sampled);
step = (x_max - x_min) / levels;
% Quantize the sampled signal
x_quantized = step * round((x_sampled - x_min) / step) + x_min;
% Plot quantized vs. sampled signal
figure;
stem(n, x_sampled, 'r', 'LineWidth', 1.5); hold on;
stem(n, x_quantized, 'b--', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Sampled Signal vs. Quantized Signal');
legend('Sampled Signal', 'Quantized Signal');
7

grid on;
% Quantization error
quantization_error = x_sampled - x_quantized;
figure;
stem(n, quantization_error, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Error');
title('Quantization Error');
grid on;