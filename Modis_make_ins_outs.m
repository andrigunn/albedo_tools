function [ins, outs] = Modis_make_ins_outs(geo_data_dir); 
%% Create in's and outs's for data selection. 
%% Output
% ins where data within the shape file is 1
% outs where data outside the shapefile is 1
%%
clc
cd([geo_data_dir,'\ins'])

%%
load('in_Hofsj.mat')
ins.in_hof = in;
ou = in; ou = ~ou;
outs.outs_hof = ou;
clear in ou
%%
load('in_Vatnaj.mat')
ins.in_vat = in;
ou = in; ou = ~ou;
outs.outs_vat = ou;
clear in ou
%%
load('in_Langj.mat')
ins.in_lan = in;
ou = in; ou = ~ou;
outs.outs_lan = ou;
clear in ou
%%
load('isl.mat')
ins.in_isl = in;
ou = in; ou = ~ou;
outs.outs_isl = ou;
clear in ou

