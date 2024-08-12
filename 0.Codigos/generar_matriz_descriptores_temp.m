function generar_matriz_descriptores()
    clear all
    close all
    clc

    % Definir el directorio de entrada y salida
    input_dir = 'C:\Users\Macbook\Documents\MATLAB\Phd\descriptores\METODOLOGIA PARA APLICAR DESCRIPTORES TEMPORALES\audios1seg\descriptores_temporales_1s_X_1hora\';
    output_dir = 'C:\Users\Macbook\Documents\MATLAB\Phd\descriptores\METODOLOGIA PARA APLICAR DESCRIPTORES TEMPORALES\audios1seg\descriptores_temporales_1s_X_1hora\matriz\';
    output_file = fullfile(output_dir, 'descriptores_temporales.xlsx');

    % Crear el directorio de salida si no existe
    if ~exist(output_dir, 'dir')
        mkdir(output_dir);
    end

    % Obtener lista de archivos de descriptores en el directorio de entrada
    descriptor_files = dir(fullfile(input_dir, '*_descrip_temp.txt'));

    % Inicializar nombres de los descriptores
    descriptor_names = {'Valor Pico (Pv)', 'Valor RMS', 'Desviación Estándar (SD)', 'Valor de Curtosis (Kv)', 'Factor de Cresta (Crf)', 'Factor de Holgura (Clf)', 'Factor de Impulso (Imf)', 'Factor de Forma (Shf)'};
    num_descriptors = length(descriptor_names);
    num_files = length(descriptor_files);
    values_matrix = zeros(num_files, num_descriptors);  % Matriz para almacenar valores de descriptores

    % Recorrer cada archivo de descriptores y extraer valores
    for k = 1:num_files
        descriptor_file = fullfile(input_dir, descriptor_files(k).name);
        fileID = fopen(descriptor_file, 'r');
        
        if fileID == -1
            disp(['Error al abrir el archivo: ', descriptor_files(k).name]);
            continue;
        end
        
        % Leer los valores de los descriptores
        values = textscan(fileID, '%*[^:]: %f', 'Delimiter', '\n');
        fclose(fileID);
        
        if length(values{1}) == num_descriptors
            values_matrix(k, :) = values{1}';
            disp(['Valores extraídos del archivo ', descriptor_files(k).name, ':']);
            disp(values{1}');
        else
            disp(['Número incorrecto de descriptores en el archivo: ', descriptor_files(k).name]);
        end
    end

    % Transponer la matriz para que los descriptores estén en filas y los archivos en columnas
    values_matrix = values_matrix';

    % Crear tabla con nombres de descriptores y valores
    descriptor_table = array2table(values_matrix, 'RowNames', descriptor_names);

    % Guardar la tabla en un archivo Excel
    writetable(descriptor_table, output_file, 'WriteRowNames', true);

    disp('El archivo Excel con los descriptores temporales se ha creado con éxito.');
end
