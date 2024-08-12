clear all
close all
clc

Leer el archivo de audio
[audio_data, sample_rate] = audioread('C:\Users\Macbook\Documents\MATLAB\Phd\11 de junio_descriptores\METODOLOGIA PARA APLICAR DESCRIPTORES TEMPORALES\0audios1min\0.R20240227-142741_Original.WAV');

% Duración de cada segmento (1 minuto)
segment_duration_sec = 1 * 60;  % 1 minuto en segundos
segment_samples = segment_duration_sec * sample_rate;  % Número de muestras por segmento

% Crear el directorio para guardar los segmentos
output_dir = 'C:\Users\Macbook\Documents\MATLAB\Phd\11 de junio_descriptores\METODOLOGIA PARA APLICAR DESCRIPTORES TEMPORALES\0audios1min';
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end

% Inicializar el contador de segmentos
segment_count = 1;

% Segmentar y guardar los archivos de audio
for start_sample = 1:segment_samples:(segment_samples * 60)
    end_sample = min(start_sample + segment_samples - 1, length(audio_data));
    segment_data = audio_data(start_sample:end_sample);
    
    % Nombre del archivo de segmento
    segment_filename = fullfile(output_dir, sprintf('audio_segment_%d.wav', segment_count));
    
    % Guardar el segmento de audio
    audiowrite(segment_filename, segment_data, sample_rate);
    
    % Incrementar el contador de segmentos
    segment_count = segment_count + 1;
    
    % Terminar si ya se han creado 60 segmentos
    if segment_count > 60
        break;
    end
end

disp('Los segmentos de audio han sido generados y guardados con éxito.');
