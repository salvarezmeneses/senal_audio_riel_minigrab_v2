clc; 
clear; 
close all; % Cierra cualquier figura abierta

% Definir las carpetas de entrada (audios) y salida (espectrogramas)
input_folder = 'C:\ruta\de\entrada'; % <-- Cambia a tu ruta real
output_folder = 'C:\ruta\de\salida'; % <-- Carpeta donde se guardarán las imágenes

% Crear carpeta de salida si no existe
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

% Listar todos los archivos .wav en la carpeta de entrada
audio_files = dir(fullfile(input_folder, '*.wav'));

% Recorrer cada archivo de audio
for k = 1:length(audio_files)
    % Leer el audio
    file_path = fullfile(input_folder, audio_files(k).name);
    [audio, Fs] = audioread(file_path);
    
    % Crear figura (sin mostrarla en pantalla para ahorrar recursos)
    figure('Visible', 'off');
    
    % Generar espectrograma
    spectrogram(audio, 256, 200, 512, Fs, 'yaxis');
    title(['Espectrograma de ', audio_files(k).name], 'Interpreter', 'none');
    xlabel('Tiempo (s)');
    ylabel('Frecuencia (Hz)');
    colorbar; % Mostrar barra de intensidad

    % Guardar la figura como imagen .png
    output_file = fullfile(output_folder, [audio_files(k).name(1:end-4), '_spectrogram.png']);
    saveas(gcf, output_file);
    
    % Cerrar figura para liberar memoria
    close(gcf);
end
