%% Make geo files for plotting MODIS data
function geo = Modis_make_geo_old(geo_data_dir)
%cd('E:\Dropbox\01 - Icelandic Snow Observatory - ISO\ISCA\05_data\geo')
cd(geo_data_dir);
load('geo_hv17.mat');
% Make geo structure
geo.lat = lat;
geo.lon = lon; 
geo.utlina_isl = shaperead('is50v_strandlina_flakar_ll');
geo.utlina_vat = shaperead('VATNAJ__UTLINA');
geo.utlina_hof = shaperead('HOFSJ_UTLINA_nn');
geo.utlina_lan = shaperead('LANGJ_UTLINA');
% Masks are as 1 outside of the shape and NAN inside of the shapefile. 
load('geoMasks.mat')
geo.masks.glaciers = geoMasks.glaciers_isl;
geo.masks.waterbodies = geoMasks.waterbodies_isl;
% Ins are 1 inside of the shape and NAN outside of the shapefile
cd('ins')
geo.ins.in_va = load('in_Vatnaj');
geo.ins.in_la = load('in_Langj');
geo.ins.in_ho = load('in_Hofsj');

