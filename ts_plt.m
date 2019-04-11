close all, clear all, clc
data_read_dir = '/Users/andrigun/Documents/data_dwl';

GRID_NAME='MOD_Grid_BRDF';
DATAFIELD_NAME='Albedo_BSA_Band1';
    geo_data_dir = '/Users/andrigun/Dropbox/01 - Icelandic Snow Observatory - ISO/ISCA/05_data/geo';
    geo = Modis_make_geo(geo_data_dir); 
cd(data_read_dir)
b = dir('*.hdf')
b = rmfield(b, {'folder', 'date', 'bytes', 'isdir', 'datenum'});
img_dir = '/Users/andrigun/Dropbox/glac_mass/mcd'
%%
draw_pre_post = 1
ki = 0
    in_glaciers = geo.ins.in_ho.in+geo.ins.in_la.in+geo.ins.in_va.in;
    in_glaciers(in_glaciers == 0) = NaN;

    for i = 1:length(b)
        ki=ki+1;
        FILE_NAME = b(i).name;
         
        [DATA, DATA_NAME, HDF_DATE] = import_MODIS_data(FILE_NAME, GRID_NAME, DATAFIELD_NAME);

        [filter_data_va,filter_average_va,cloud_cover_va] = in_filter(DATA,  geo.ins.in_va.in, nan, draw_pre_post);
        %[filter_data_ho,filter_average_ho,cloud_cover_ho] = in_filter(DATA,  geo.ins.in_ho.in, nan, draw_pre_post);
        %[filter_data_la,filter_average_la,cloud_cover_la] = in_filter(DATA,  geo.ins.in_la.in, nan, draw_pre_post);

              T(ki) = [cloud_cover_va];
              TT(ki) = {DATA_NAME};
               
               %DATA_M(:,:,ki) = DATA;
   data = DATA.*in_glaciers;
    date_data = ['Dags: ', DATA_NAME(9:15)];
    
    Modis_plotter_albedo(data,geo,date_data,img_dir)

    end
    %%
    %DATA = nanmean(DATA,3);

