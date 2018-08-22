clear all, close all, clc
%% Download newest MCD43A3 data
%system('sh /Users/andrigun/dwl_mcd43a3.sh')


%% Testing
cd('/Users/andrigun/Documents/GitHub/albedo_tools')
addpath('/Users/andrigun/Documents/GitHub/albedo_tools')

data_read_dir = '/Volumes/brunnur/data/MCD43A3';
data_write_dir = '/Users/andrigun';
img_dir = '/Volumes/brunnur/data/MCD43A3';

geo_data_dir = '/Users/andrigun/Dropbox/01 - Icelandic Snow Observatory - ISO/ISCA/05_data/geo';
geo = Modis_make_geo(geo_data_dir)

draw_pre_post = 0;
GRID_NAME='MOD_Grid_BRDF';
DATAFIELD_NAME='Albedo_BSA_Band1';

% Find all files in Directory
    cd(data_read_dir)
    d = dir('MCD43A3*');
    xi = size(d);
% READ TEXTFILE TO SEE WHAT FILES ARE MISSING
    cd(data_write_dir)
    old = load('MCD43A3_joklar_tmp.txt')
    newst_date_in_file = old(end,1)

cd(data_read_dir)
    for i = 1:xi;
        d(i).yeardoy = str2num(d(i).name(10:16))
    end
    
tmp = [d(:).yeardoy];
ind_start_date = find(tmp==newst_date_in_file)
new_hdf_date = tmp(end)
ind_start_date = ind_start_date +1;

if new_hdf_date == newst_date_in_file
    sprintf('No new data since last run')
else
    for i = 1:xi(1)
        FILE_NAME = d(i).name;
        [DATA, DATA_NAME, HDF_DATE] = import_MODIS_data(FILE_NAME, GRID_NAME, DATAFIELD_NAME); 

        [filter_data_va,filter_average_va] = in_filter(DATA,  geo.ins.in_va.in, nan, draw_pre_post);
        [filter_data_ho,filter_average_ho] = in_filter(DATA,  geo.ins.in_ho.in, nan, draw_pre_post);
        [filter_data_la,filter_average_la] = in_filter(DATA,  geo.ins.in_la.in, nan, draw_pre_post);

        DR = [str2num(HDF_DATE),filter_average_va,filter_average_ho,filter_average_la];
        dlmwrite('/Users/andrigun/MCD43A3_joklar.txt',DR,'-append','precision','%.4f');
        sprintf('Data added')
    end
end