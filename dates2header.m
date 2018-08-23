
    HDF_DATE = A.Date(end);
    date_on_graph = num2str(HDF_DATE);
    yyear = date_on_graph(1,1:4);
    ddoy= date_on_graph(1,5:end);
    dv = datenum(yyear,'yyyy');
    MOD_DATE_NUM = dv-1+str2num(ddoy);
    MOD_DATE_STR = timebuilder(MOD_DATE_NUM)
    
%     [data(i).year] = MOD_DATE_STR(i,1);
%     [data(i).month] = MOD_DATE_STR(i,2);
%     [data(i).day] = MOD_DATE_STR(i,3);
%     [data(i).hour] = MOD_DATE_STR(i,4);
%     [data(i).second] = MOD_DATE_STR(i,5);
%     [data(i).doy] = MOD_DATE_STR(i,6);
%     [data(i).daten] = MOD_DATE_STR(i,7);
