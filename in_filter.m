function [filter_data,filter_average, cloud_cover] = in_filter(unfilter_data, in, fill_value, draw_pre_post)

%% Lesum inn in skr� me� indexum fyrir gildi sem vi� viljum ey�a �t. Fill value er gildi � breytu sem er skr�� � sta� gilda

%% FOR TESTING
%in = geo.ins.in_va.in;
% in = in_va.in;
% draw_pre_post = 1;
% unfilter_data = DATA;
% fill_value = nan
% draw_pre_post = 1


filter_data = in.*unfilter_data;                    % Make NAN outside of ins file
filter_data(filter_data  == 0) = -1^20;             % Make zeros tiny
filter_data = in.*filter_data;     
filter_data(filter_data  == 0) = fill_value;        % Set fill value
filter_data(filter_data  == -1^20) = 0;             % 
filter_average = nanmean(nanmean(filter_data));
%% Count Clouds for ins
filter_data_clouds = in.*unfilter_data;  
filter_data_clouds(filter_data_clouds  == 0) = -1^20;    
filter_data_clouds = in.*filter_data_clouds;    
filter_data_clouds(filter_data_clouds  == 0) = fill_value;
filter_data_clouds(filter_data_clouds  == -1^20) = 0;  

filter_data_clouds(filter_data_clouds  > 0) = 2; 
filter_data_clouds(isnan(filter_data_clouds))=1;
filter_data_clouds = in.*filter_data_clouds;
%% 
no_cloud_pixels = sum(filter_data_clouds(:) == 1);
no_data_pixels = sum(filter_data_clouds(:) == 2);
no_ins_pixels = sum(in(:) == 1);

make_sum_re = no_cloud_pixels+no_data_pixels;
sumDiff = make_sum_re-no_ins_pixels;

cloud_cover = no_cloud_pixels/no_ins_pixels;

    if sumDiff == 0 
        sprintf('Difference sum of data and clouds is ZERO, analysis GOOD')
    else
        sprintf('Difference sum of data and clouds is NOT ZERO, analysis BAD') 
    end


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    