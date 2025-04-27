% fecha: 26-abril-2025

clear all
close all
clc

% Leer el archivo de audio (que está en la misma carpeta)
[audio, fs] = audioread('C:\Users\ThinkBook\Documents\MATLAB\26_abril_2025_matlab\2.Audios_segmentos_1s\0001_audio_hdg_hora_1.WAV');


% Crear vector de tiempo y graficar
plot((0:length(audio)-1)/fs, audio);
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('señal temporal audio ');
grid on;
