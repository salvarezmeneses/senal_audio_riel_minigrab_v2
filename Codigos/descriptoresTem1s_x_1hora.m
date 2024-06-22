clear all
close all
clc

% Definir el directorio de entrada y salida
input_dir = 'C:\Users\Macbook\Documents\MATLAB\Phd\descriptores\METODOLOGIA PARA APLICAR DESCRIPTORES TEMPORALES\audios1seg\Audios_segmentos_1s\';
output_dir = 'C:\Users\Macbook\Documents\MATLAB\Phd\descriptores\METODOLOGIA PARA APLICAR DESCRIPTORES TEMPORALES\audios1seg\Audios_segmentos_1s\descriptores_temporales_1s_X_1hora';
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end

% Obtener lista de archivos de audio en el directorio de entrada
audio_files = dir(fullfile(input_dir, '*.wav'));

% Recorrer cada archivo de audio
for k = 1:length(audio_files)
    % Leer el archivo de audio
    audio_file = fullfile(input_dir, audio_files(k).name);
    [audio_data, sample_rate] = audioread(audio_file);

    % Normalizar el audio para asegurar que los valores estén dentro del rango [-1, 1]
    audio_data = audio_data / max(abs(audio_data));

    % Dividir el audio en segmentos de 1 segundo
    segment_duration = 1; % Duración de cada segmento en segundos
    segment_samples = segment_duration * sample_rate; % Número de muestras por segmento
    num_segments = floor(length(audio_data) / segment_samples); % Número de segmentos completos

    % Generar nombre de archivo de salida para descriptores temporales
    [~, audio_name, ~] = fileparts(audio_files(k).name);
    descriptores_filename = fullfile(output_dir, [audio_name, '_descrip_temp.txt']);
    fileID = fopen(descriptores_filename, 'w');

    for seg = 1:num_segments
        segment_start = (seg - 1) * segment_samples + 1;
        segment_end = seg * segment_samples;
        segment_data = audio_data(segment_start:segment_end);

        % Calcular descriptores temporales para el segmento
        % 1. Valor Pico (Pv)
        Pv = (1/2) * (max(segment_data) - min(segment_data));

        % 2. Valor RMS (RMS)
        RMS = sqrt(mean(segment_data.^2));

        % 3. Desviación Estándar (SD)
        SD = std(segment_data);

        % 4. Valor de Curtosis (Kv)
        Kv = kurtosis(segment_data);

        % 5. Factor de Cresta (Crf)
        Crf = Pv / RMS;

        % 6. Factor de Holgura (Clf)
        Clf = (1/length(segment_data)) * sum(abs(segment_data) / Pv);

        % 7. Factor de Impulso (Imf)
        Imf = max(abs(segment_data)) / mean(abs(segment_data));

        % 8. Factor de Forma (Shf)
        Shf = RMS / mean(abs(segment_data));

        % Guardar descriptores en el archivo
        fprintf(fileID, 'Valor Pico (Pv): %.2f\n', Pv);
        fprintf(fileID, 'Valor RMS: %.2f\n', RMS);
        fprintf(fileID, 'Desviación Estándar (SD): %.2f\n', SD);
        fprintf(fileID, 'Valor de Curtosis (Kv): %.2f\n', Kv);
        fprintf(fileID, 'Factor de Cresta (Crf): %.2f\n', Crf);
        fprintf(fileID, 'Factor de Holgura (Clf): %.2f\n', Clf);
        fprintf(fileID, 'Factor de Impulso (Imf): %.2f\n', Imf);
        fprintf(fileID, 'Factor de Forma (Shf): %.2f\n', Shf);
        fprintf(fileID, '\n'); % Línea en blanco para separar segmentos

        disp(['Los descriptores temporales para el segmento ', num2str(seg), ' de ', audio_name, ' han sido calculados y guardados con éxito.']);
    end

    fclose(fileID);
end

disp('El procesamiento de todos los archivos de audio ha finalizado.');
