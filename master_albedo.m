clear all, close all, clc
%% Download newest MCD43A3 data
system('sh /Users/andrigun/dwl_mcd43a3.sh')
%% Main settings
%cd('/Users/andrigun/Documents/GitHub/albedo_tools')
addpath('/Users/andrigun/Documents/GitHub/albedo_tools')
data_read_dir = '/Volumes/brunnur/data/MCD43A3';
data_write_dir = '/Users/andrigun';
img_dir = '/Volumes/brunnur/brunnur_results/img';
geo_data_dir = '/Users/andrigun/Dropbox/01 - Icelandic Snow Observatory - ISO/ISCA/05_data/geo';
geo = Modis_make_geo(geo_data_dir)
% Other settings
draw_pre_post = 0;
GRID_NAME='MOD_Grid_BRDF';
DATAFIELD_NAME='Albedo_BSA_Band1';
%% CODE STARTS %%
%% Find all files in Directory
    cd(data_read_dir)
    d = dir('MCD43A3*');
    xi = size(d);
%% READ TEXTFILE TO SEE WHAT FILES ARE MISSING
    cd(data_write_dir)
    %old = load('MCD43A3_joklar_tmp.txt')
    load('TS_Glaciers_MCD43A3.mat')
    newst_date_in_file = TS_Glaciers_MCD43A3.Date(end)
%%
cd(data_read_dir);
        for i = 1:xi;
            d(i).yeardoy = str2num(d(i).name(10:16));
        end

    tmp = [d(:).yeardoy];
    ind_start_date = find(tmp==newst_date_in_file);
    new_hdf_date = tmp(end);
    datediff = new_hdf_date-newst_date_in_file;
    ind_start_date = ind_start_date +1;
%% Skrár sem þarf að uppfæra
% MCD43A3.A2016245.h17v02.006.2016256231200.hdf'
if datediff == 0
    sprintf('No new data since last run')
else
     sprintf([num2str(datediff),' new datasets to process'])
      TEMP_DATA = [0,0,0,0,0,0,0];
     
    for i = ind_start_date:xi(1)
        FILE_NAME = d(i).name;
         sprintf(['Processing file: ',FILE_NAME])
        [DATA, DATA_NAME, HDF_DATE] = import_MODIS_data(FILE_NAME, GRID_NAME, DATAFIELD_NAME); 

        [filter_data_va,filter_average_va,cloud_cover_va] = in_filter(DATA,  geo.ins.in_va.in, nan, draw_pre_post);
        [filter_data_ho,filter_average_ho,cloud_cover_ho] = in_filter(DATA,  geo.ins.in_ho.in, nan, draw_pre_post);
        [filter_data_la,filter_average_la,cloud_cover_la] = in_filter(DATA,  geo.ins.in_la.in, nan, draw_pre_post);

        DR = [str2num(HDF_DATE),filter_average_va,filter_average_ho,filter_average_la,cloud_cover_va,cloud_cover_ho,cloud_cover_la];
        dlmwrite('/Users/andrigun/MCD43A3_joklar.txt',DR,'-append','precision','%.4f');
        
        TEMP_DATA = [TEMP_DATA;DR];        
    end
    
    TEMP_DATA(1,:) = [];
    S = num2str(TEMP_DATA(:,1));
    TEMP_DATA(:,8) = str2num(S(:,1:4));
    TEMP_DATA(:,9) = str2num(S(:,5:7));


%% Make the data table
TS_Glaciers_MCD43A3_dt = array2table(TEMP_DATA,...
    'VariableNames',{'Date','Va_alb','Ho_alb','La_alb','Va_cc','Ho_cc','La_cc','Year','doy'});
%%
TS_Glaciers_MCD43A3 = [TS_Glaciers_MCD43A3;TS_Glaciers_MCD43A3_dt]

save([data_write_dir,'/TS_Glaciers_MCD43A3'],'TS_Glaciers_MCD43A3'); 
%% 
cd(img_dir)
dir_name = ['MCD43A3_alb_cc_',datestr(now,'yyyymmdd')]
mkdir(dir_name);
cd(dir_name)
    plot_albedo
    plot_cloudcover

end








