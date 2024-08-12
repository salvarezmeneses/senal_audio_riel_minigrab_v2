clear all
close all
clc

% Leer el archivo de audio
[audio_data, sample_rate] = audioread('C:\Users\Macbook\Documents\MATLAB\Phd\11 de junio_descriptores\METODOLOGIA PARA APLICAR DESCRIPTORES TEMPORALES\audios1seg\0.R20240227-142741_Original.WAV');

% Duración de cada segmento (1 segundo)
segment_duration_sec = 1;  % 1 segundo en segundos
segment_samples = segment_duration_sec * sample_rate;  % Número de muestras por segmento

% Crear el directorio para guardar los segmentos
output_dir = 'C:\Users\Macbook\Documents\MATLAB\Phd\11 de junio_descriptores\METODOLOGIA PARA APLICAR DESCRIPTORES TEMPORALES\segmentos_1s';
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end

% Inicializar el contador de segmentos
segment_count = 1;

% Número total de segmentos
num_segments = floor(length(audio_data) / segment_samples);

% Segmentar y guardar los archivos de audio
for i = 1:num_segments
    start_sample = (i - 1) * segment_samples + 1;
    end_sample = i * segment_samples;
    segment_data = audio_data(start_sample:end_sample);
    
    % Nombre del archivo de segmento
    segment_filename = fullfile(output_dir, sprintf('%04d_audio_hdg_hora_1.wav', segment_count));
    
    % Guardar el segmento de audio
    audiowrite(segment_filename, segment_data, sample_rate);
    
    % Incrementar el contador de segmentos
    segment_count = segment_count + 1;
end

disp('Los segmentos de audio han sido generados y guardados con éxito.');
