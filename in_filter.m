function [filter_data,filter_average] = in_filter(unfilter_data, in, fill_value, draw_pre_post)

%% Lesum inn in skrá með indexum fyrir gildi sem við viljum eyða út. Fill value er gildi á breytu sem er skráð í stað gilda

%% FOR TESTING
% in_va = load('F:\Maelingar\brunnur\geo\in_Vatnaj');
% in = in_va.in;
% draw_pre_post = 1;
% unfilter_data = DATA;
% fill_value = nan
% draw_pre_post = 1


filter_data = in.*unfilter_data;
filter_data(filter_data  == 0) = -1^20;
filter_data = in.*filter_data;
filter_data(filter_data  == 0) = fill_value;
filter_data(filter_data  == -1^20) = 0;

filter_average = nanmean(nanmean(filter_data));

if draw_pre_post == 1;
    plot_modisHDF(unfilter_data);
    
    plot_modisHDF(filter_data);
else
end