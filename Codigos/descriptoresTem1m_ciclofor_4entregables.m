clear all
close all
clc

% Definir el directorio de entrada y salida
input_dir = 'C:\Users\Macbook\Documents\MATLAB\Phd\11 de junio_descriptores\METODOLOGIA PARA APLICAR DESCRIPTORES TEMPORALES\0audios1min\1señal de audio1min\Segmentos1min\';
output_dir = 'C:\Users\Macbook\Documents\MATLAB\Phd\11 de junio_descriptores\METODOLOGIA PARA APLICAR DESCRIPTORES TEMPORALES\0audios1min\1señal de audio1min\Segmentos1min\Resultados\';
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

    % Aplicar FFT
    n = length(audio_data); % Número de muestras
    f = (0:n-1)*(sample_rate/n); % Vector de frecuencias
    Y = fft(audio_data); % Transformada de Fourier

    % Magnitud de la FFT
    magnitudeY = abs(Y);

    % Graficar el espectro de frecuencias
    figure;
    plot(f, magnitudeY);
    title('Espectro de Frecuencias del Audio');
    xlabel('Frecuencia (Hz)');
    ylabel('Magnitud');
    xlim([0 sample_rate/2]); % Mostrar solo hasta la frecuencia de Nyquist
    grid on;

    % Guardar la figura en formato JPEG
    [~, audio_name, ~] = fileparts(audio_files(k).name);
    saveas(gcf, fullfile(output_dir, ['espectro_frecuencias_', audio_name, '.jpeg']));
    close(gcf);

    % Resumir el contenido frecuencial
    % Solo considerar la primera mitad de las frecuencias (hasta la frecuencia de Nyquist)
    half_n = floor(n/2);
    frequencies = f(1:half_n);
    magnitudes = magnitudeY(1:half_n);

    % Guardar el contenido frecuencial en un archivo de texto
    contenido_frecuencial_filename = fullfile(output_dir, ['contenido_frecuencial_', audio_name, '.txt']);
    fileID = fopen(contenido_frecuencial_filename, 'w');
    for i = 1:half_n
        fprintf(fileID, 'Frecuencia: %.2f Hz, Magnitud: %.2f\n', frequencies(i), magnitudes(i));
    end
    fclose(fileID);

    % Encontrar las frecuencias con mayor magnitud
    [sorted_magnitudes, indices] = sort(magnitudes, 'descend');
    top_frequencies = frequencies(indices);

    % Mostrar las 10 frecuencias más significativas
    num_top_frequencies = 10;
    disp('Resumen del contenido frecuencial de la señal de audio:');
    for i = 1:num_top_frequencies
        fprintf('Frecuencia: %.2f Hz, Magnitud: %.2f\n', top_frequencies(i), sorted_magnitudes(i));
    end

    % Guardar las 10 frecuencias más significativas en un archivo de texto
    top_frecuencias_filename = fullfile(output_dir, ['top_frecuencias_', audio_name, '.txt']);
    fileID = fopen(top_frecuencias_filename, 'w');
    for i = 1:num_top_frequencies
        fprintf(fileID, 'Frecuencia: %.2f Hz, Magnitud: %.2f\n', top_frequencies(i), sorted_magnitudes(i));
    end
    fclose(fileID);

    % Calcular descriptores temporales
    % 1. Valor Pico (Pv)
    Pv = (1/2) * (max(audio_data) - min(audio_data));

    % 2. Valor RMS (RMS)
    RMS = sqrt(mean(audio_data.^2));

    % 3. Desviación Estándar (SD)
    SD = std(audio_data);

    % 4. Valor de Curtosis (Kv)
    Kv = kurtosis(audio_data);

    % 5. Factor de Cresta (Crf)
    Crf = Pv / RMS;

    % 6. Factor de Holgura (Clf)
    Clf = (1/length(audio_data)) * sum(abs(audio_data) / Pv);

    % 7. Factor de Impulso (Imf)
    Imf = max(abs(audio_data)) / mean(abs(audio_data));

    % 8. Factor de Forma (Shf)
    Shf = RMS / mean(abs(audio_data));

    % Mostrar resultados
    disp(['Valor Pico (Pv): ', num2str(Pv)]);
    disp(['Valor RMS: ', num2str(RMS)]);
    disp(['Desviación Estándar (SD): ', num2str(SD)]);
    disp(['Valor de Curtosis (Kv): ', num2str(Kv)]);
    disp(['Factor de Cresta (Crf): ', num2str(Crf)]);
    disp(['Factor de Holgura (Clf): ', num2str(Clf)]);
    disp(['Factor de Impulso (Imf): ', num2str(Imf)]);
    disp(['Factor de Forma (Shf): ', num2str(Shf)]);

    % Guardar descriptores en un archivo
    descriptores_filename = fullfile(output_dir, ['descriptores_temporales_', audio_name, '.txt']);
    fileID = fopen(descriptores_filename, 'w');
    fprintf(fileID, 'Valor Pico (Pv): %.2f\n', Pv);
    fprintf(fileID, 'Valor RMS: %.2f\n', RMS);
    fprintf(fileID, 'Desviación Estándar (SD): %.2f\n', SD);
    fprintf(fileID, 'Valor de Curtosis (Kv): %.2f\n', Kv);
    fprintf(fileID, 'Factor de Cresta (Crf): %.2f\n', Crf);
    fprintf(fileID, 'Factor de Holgura (Clf): %.2f\n', Clf);
    fprintf(fileID, 'Factor de Impulso (Imf): %.2f\n', Imf);
    fprintf(fileID, 'Factor de Forma (Shf): %.2f\n', Shf);
    fclose(fileID);

    disp(['Los descriptores temporales para ', audio_name, ' han sido calculados y guardados con éxito.']);
end

disp('El procesamiento de todos los archivos de audio ha finalizado.');
