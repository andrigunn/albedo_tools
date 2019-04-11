%% Reads in MODIS/Terra HDF-EOS2 data
% Andri Gunnarsson
% July 2017
% Tested for MOD10A1, MYD10A1, MCD43A3, MOD10A2

%% Inputs                               
% 1) FILE_NAME, name of file to extract data from                          
% 2) GRID_NAME, 
% 3) DATAFIELD_NAME
% 4) IN_FILTER, IN mask where 1 is data to be used and 0 is data to be
% converted to NAN
%% OUTPUT
% 1) Data from the FILE_NAME HDFEOS2 hdf file

% MCD43A3: https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/mcd43a3_v006 
% MOD10A1: https://nsidc.org/data/docs/daac/mod10_modis_snow/version_5/mod10a1_local_attributes.html
% MOD10A2: https://nsidc.org/data/MOD10A2

%SYNTAX
%%
function [DATA, DATA_NAME,HDF_DATE] = import_MODIS_data(FILE_NAME, GRID_NAME, DATAFIELD_NAME) 

%% FOR TESTING

%% FOR MCD43A3
% FILE_NAME= 'MCD43A3.A2017143.h17v02.006.2017152031227.hdf';
% GRID_NAME='MOD_Grid_BRDF';
% DATAFIELD_NAME='Albedo_BSA_Band1';

%% FOR MOD10A1
% FILE_NAME= 'MOD10A1.A2017150.h17v02.006.2017152030919.hdf'
% GRID_NAME= 'MOD_Grid_Snow_500m'
% DATAFIELD_NAME='NDSI_Snow_Cover';
% DATAFIELD_NAME='Snow_Albedo_Daily_Tile'

%% FOR MYD10A1
% FILE_NAME= 'MYD10A1.A2017151.h17v02.006.2017153030925.hdf'
% GRID_NAME= 'MOD_Grid_Snow_500m'
% DATAFIELD_NAME='NDSI_Snow_Cover';
% DATAFIELD_NAME='Snow_Albedo_Daily_Tile'

%% FOR MOD10A2
% FILE_NAME= 'MOD10A2.A2017089.h17v02.006.2017098034430.hdf'
% GRID_NAME= 'MOD_Grid_Snow_500m'
% DATAFIELD_NAME='Maximum_Snow_Extent';

%% Settings
HDF_DATE = FILE_NAME(10:16);  %Dagsetning � skr�nni sem lesin er inn
HDF_PRODUCT = FILE_NAME(1:7); %Breyta � skr�nni sem lesin er inn MOD/MCD og svo framv.
DATA_NAME = [HDF_PRODUCT '_' HDF_DATE '_' DATAFIELD_NAME]; % Nafn � skr�nni sem kemur �t
%%
% Fill value and scale settings %% Sj� � lei�beiningum me� g�gnum
if HDF_PRODUCT == 'MCD43A3';
    scale_factor = 0.001;       %    
    fill_value = 32767;         %
    replace_fill_value = nan;   %
elseif HDF_PRODUCT == 'MOD10A1';
    scale_factor = 1;           % Sk�lun er ekki notu� � MOD10A1
    fill_value = 255;           %
    remove_values_larger_than = 100;        %
    replace_fill_value = nan;   %
elseif HDF_PRODUCT == 'MYD10A1';
    scale_factor = 1;           % Sk�lun er ekki notu� � MOD10A1
    fill_value = 255;           %
    remove_values_larger_than = 100;        %
    replace_fill_value = nan;   %
elseif HDF_PRODUCT == 'MOD10A2';
    scale_factor = 1;           % Sk�lun er ekki notu� � MOD10A1
    fill_value = 255;           %
    remove_values_larger_than = 200;        
    remove_values_smaller_than = 25;
    replace_fill_value = nan;   %
end
% CODE
% Open the HDF-EOS2 Grid file.
    data = hdfread(FILE_NAME, GRID_NAME, 'Fields', DATAFIELD_NAME);
% Convert the data to double type for plot.
    data=double(data);
% Transpose the data to match the map projection.
    data=data*scale_factor;
% Remove fill value with 
if HDF_PRODUCT == 'MOD10A1';
        data(data > remove_values_larger_than) = replace_fill_value;       
    elseif HDF_PRODUCT == 'MYD10A1';
        data(data > remove_values_larger_than) = replace_fill_value;    
    elseif HDF_PRODUCT == 'MOD10A2';
        data(data > remove_values_larger_than) = replace_fill_value;    
        data(data < remove_values_smaller_than) = replace_fill_value;    
        data(data == 37) = replace_fill_value;  %lake    
        data(data == 39) = replace_fill_value;  %ocean  
        data(data == 50) = replace_fill_value;  %cloud  
        data(data == 100) = replace_fill_value; %lake ice   
    elseif HDF_PRODUCT == 'MYD10A2';
        data(data > remove_values_larger_than) = replace_fill_value;    
        data(data < remove_values_smaller_than) = replace_fill_value;    
        data(data == 37) = replace_fill_value;  %lake    
        data(data == 39) = replace_fill_value;  %ocean  
        data(data == 50) = replace_fill_value;  %cloud  
        data(data == 100) = replace_fill_value; %lake ice   
    else
        data(data == fill_value*scale_factor) = replace_fill_value;
end

DATA = data;





