% fecha:26-abril- 2025
%Creación: Estefany Alvarez

close all;
clear;
clc;

% Paso 1: Leer audio
[audio, Fs] = audioread(['C:\Users\ThinkBook\Documents\MATLAB\26_abril_2025_matlab\2.Audios_segmentos_1s\0001_audio_hdg_hora_1.WAV']);

% Paso 2: Vector de tiempo (para referencia visual)
t = (0:length(audio)-1)/Fs;

% Paso 3: Gráfica del escalograma usando Transformada Wavelet Continua (CWT)
figure;
cwt(audio, Fs);
title('Escalograma (Transformada Wavelet Continua) del audio ');
xlabel('Tiempo (s)');
ylabel('Frecuencia (Hz)');
