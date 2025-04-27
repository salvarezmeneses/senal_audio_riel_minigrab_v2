%fecha: 26_abril_2025

close all; % Cierra todas las figuras abiertas
clear;     % Borra todas las variables del workspace
clc;       % Limpia la ventana de comandos

% Definir las rutas de las carpetas de entrada (audios) y salida (imágenes CWT)
input_folder = 'C:\Users\ThinkBook\Documents\MATLAB\26_abril_2025_matlab\2.Audios_segmentos_1s';
output_folder = 'C:\Users\ThinkBook\Documents\MATLAB\26_abril_2025_matlab\3.CWT_imagenes';

% Crear la carpeta de salida si no existe
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

% Obtener la lista de archivos .WAV en la carpeta de entrada
audio_files = dir(fullfile(input_folder, '*.WAV'));

% Bucle para procesar cada archivo de audio
for k = 1:length(audio_files)
    % Leer el archivo de audio
    [audio, Fs] = audioread(fullfile(input_folder, audio_files(k).name));
    
    % Crear figura para la CWT (sin mostrarla en pantalla)
    figure('Visible', 'off');
    cwt(audio, Fs); % Calcular y graficar la Transformada Wavelet Continua
    title(['Escalograma de ', audio_files(k).name], 'Interpreter', 'none');
    xlabel('Tiempo (s)');
    ylabel('Frecuencia (Hz)');
    
    % Guardar la figura como imagen PNG en la carpeta de salida
    saveas(gcf, fullfile(output_folder, [audio_files(k).name(1:end-4), '_CWT.png']));
    
    % Cerrar la figura para liberar memoria
    close(gcf);
end

