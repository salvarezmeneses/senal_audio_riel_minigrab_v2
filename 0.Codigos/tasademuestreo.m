
clear all
close all
clc

% Especificar la ruta completa al archivo
%file_path = 'C:\Users\Macbook\Documents\MATLAB\Phd\11 de junio_descriptores\METODOLOGIA PARA APLICAR DESCRIPTORES TEMPORALES\1.Adquisicion de la señal de audio\0.R20240227-142741_Original.WAV';
file_path = 'C:\Users\Macbook\Documents\MATLAB\Phd\11 de junio_descriptores\METODOLOGIA PARA APLICAR DESCRIPTORES TEMPORALES\1.Adquisicion de la señal de audio\Segmentos en wav\1audio_segment_1.wav';

% Leer el archivo de audio
[audio_data, sample_rate] = audioread(file_path);

% Mostrar la tasa de muestreo
disp(['Tasa de muestreo: ', num2str(sample_rate), ' Hz']);

