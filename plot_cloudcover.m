%% Plotting
A = TS_Glaciers_MCD43A3 ;
% Newest data timestamp
    HDF_DATE = A.Date(end);
    date_on_graph = num2str(HDF_DATE);
    yyear = date_on_graph(1,1:4);
    ddoy= date_on_graph(1,5:end);
    dv = datenum(yyear,'yyyy');
    MOD_DATE_NUM = dv-1+str2num(ddoy);
    MOD_DATE_STR = timebuilder(MOD_DATE_NUM)
% Years to use a reference
    Current_Year = year(now)
    Last_Year = year(now)-1
    Last_Last_Year = year(now)-2
%
    xi = find(TS_Glaciers_MCD43A3.Year == Current_Year);
    xii = find(TS_Glaciers_MCD43A3.Year == Last_Year);
    xiii = find(TS_Glaciers_MCD43A3.Year == Last_Last_Year);

window_size = 7;
    Mva = movAv(TS_Glaciers_MCD43A3.Va_cc,window_size)
    Mho = movAv(TS_Glaciers_MCD43A3.Ho_cc,window_size)
    Mla = movAv(TS_Glaciers_MCD43A3.La_cc,window_size)

%%
for i = 1:365
    x = find(A.doy(:) == i)
    ltm_va  = nanmedian(A.Va_cc(x)) 
    maxx_va = nanmax(A.Va_cc(x)) 
    minn_va = nanmin(A.Va_cc(x))  
    stdev_va = nanstd(A.Va_cc(x))  
    
    stats.doy(i) = i
    stats.ltm_va(i) = ltm_va
    stats.maxx_va(i) = maxx_va
    stats.minn_va(i) = minn_va
    stats.stdev_va(i) = stdev_va
    
    
    ltm_ho  = nanmedian(A.Ho_cc(x)) 
    maxx_ho = nanmax(A.Ho_cc(x)) 
    minn_ho = nanmin(A.Ho_cc(x))  
    stdev_ho = nanstd(A.Ho_cc(x))  
    
    stats.ltm_ho(i) = ltm_ho
    stats.maxx_ho(i) = maxx_ho
    stats.minn_ho(i) = minn_ho
    stats.stdev_ho(i) = stdev_ho
    
    
    ltm_la  = nanmedian(A.La_cc(x)) 
    maxx_la = nanmax(A.La_cc(x)) 
    minn_la = nanmin(A.La_cc(x))  
    stdev_la = nanstd(A.La_cc(x))  
    
    stats.ltm_la(i) = ltm_la
    stats.maxx_la(i) = maxx_la
    stats.minn_la(i) = minn_la
    stats.stdev_la(i) = stdev_la
        
end

%% Plot for Vatnajökull     
close all

fva =figure(), hold on 

C = [192/255 192/255 192/255];
minax = 0
maxax = 1

plot(stats.doy,stats.ltm_va,'color','k','Linewidth',1.2)
plot(stats.doy,stats.ltm_va+stats.stdev_va,'color',C,'Linewidth',1.2)
plot(A.doy(xi),Mva(xi),'r','Linewidth',1.3)
plot(A.doy(xii),Mva(xii),'r--')
plot(A.doy(xiii),Mva(xiii),'bl--')

legend('Median','+/- std',num2str(Current_Year),num2str(Last_Year),num2str(Last_Last_Year),'AutoUpdate','off')
plot(stats.doy,stats.ltm_va-stats.stdev_va,'color',C,'Linewidth',1.2)

xlabel('Dagur ársins')
ylabel('Skýjahula (-)')

plot([31,31],[0,1],'color',C,'LineStyle','--')
plot([60,60],[0,1],'color',C,'LineStyle','--')
plot([91,91],[0,1],'color',C,'LineStyle','--')
plot([121,121],[0,1],'color',C,'LineStyle','--')
plot([152,152],[0,1],'color',C,'LineStyle','--')
plot([182,182],[0,1],'color',C,'LineStyle','--')
plot([213,213],[0,1],'color',C,'LineStyle','--')
plot([244,244],[0,1],'color',C,'LineStyle','--')
plot([274,274],[0,1],'color',C,'LineStyle','--')
plot([305,305],[0,1],'color',C,'LineStyle','--')
plot([335,335],[0,1],'color',C,'LineStyle','--')

%
FS= 12;
plus_txt = 0.01
%text((31)/2,minax+plus_txt,'Jan�ar','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
%text((60+31)/2,minax+plus_txt,'Febr�ar','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
%text((91+60)/2,minax+plus_txt,'Mars','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((91+121)/2,minax+plus_txt,'Apríl','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((121+152)/2,minax+plus_txt,'Maí','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((152+182)/2,minax+plus_txt,'Júní','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((182+213)/2,minax+plus_txt,'Júlí','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((213+244)/2,minax+plus_txt,'Ágúst','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((244+274)/2,minax+plus_txt,'Sept.','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((274+305)/2,minax+plus_txt,'Okt.','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
%text((305+335)/2,minax+plus_txt,'N�v.','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
%text((335+365)/2,minax+plus_txt,'Des.','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);

title('Vatnajökull Skýjahula: 0-2100 m y.s.')

text(1,-0.005,'NASA MCD43A3 V006 data / Landsvirkjun Rannsóknir ','Units','normalized','HorizontalAlignment','left','VerticalAlignment','top', 'rotation',90,'color',C,'Fontsize',FS/1.25);
text(1.03,-0.005,['ver. ',datestr(now,'yyyy.mm.dd')],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','top', 'rotation', 90,'color',C,'Fontsize',FS/1.25);
text(0.01,0.99,['Nýjustu gögn: ',datestr(MOD_DATE_NUM)],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','top', 'rotation',0,'color',C,'Fontsize',FS/1.25);

xlim([91 305])
ylim([minax maxax])

fig_name = ['MCD43A3_cc_va_ts_ver_',datestr(now,'yyyymmdd')]
saveas(fva,fig_name,'png');

% HO
fho =figure(), hold on 
plot(stats.doy,stats.ltm_ho,'color','k','Linewidth',1.2)
plot(stats.doy,stats.ltm_ho+stats.stdev_ho,'color',C,'Linewidth',1.2)
plot(A.doy(xi),Mho(xi),'r','Linewidth',1.3)
plot(A.doy(xii),Mho(xii),'r--')
plot(A.doy(xiii),Mho(xiii),'bl--')

legend('Median','+/- std',num2str(Current_Year),num2str(Last_Year),num2str(Last_Last_Year),'AutoUpdate','off')
plot(stats.doy,stats.ltm_ho-stats.stdev_ho,'color',C,'Linewidth',1.2)

xlabel('Dagur Ársins')
ylabel('Skýjahula (-)')

plot([31,31],[0,1],'color',C,'LineStyle','--')
plot([60,60],[0,1],'color',C,'LineStyle','--')
plot([91,91],[0,1],'color',C,'LineStyle','--')
plot([121,121],[0,1],'color',C,'LineStyle','--')
plot([152,152],[0,1],'color',C,'LineStyle','--')
plot([182,182],[0,1],'color',C,'LineStyle','--')
plot([213,213],[0,1],'color',C,'LineStyle','--')
plot([244,244],[0,1],'color',C,'LineStyle','--')
plot([274,274],[0,1],'color',C,'LineStyle','--')
plot([305,305],[0,1],'color',C,'LineStyle','--')
plot([335,335],[0,1],'color',C,'LineStyle','--')

%
FS= 12;
plus_txt = 0.01
%text((31)/2,minax+plus_txt,'Jan�ar','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
%text((60+31)/2,minax+plus_txt,'Febr�ar','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
%text((91+60)/2,minax+plus_txt,'Mars','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((91+121)/2,minax+plus_txt,'Apríl','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((121+152)/2,minax+plus_txt,'Maí','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((152+182)/2,minax+plus_txt,'Júní','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((182+213)/2,minax+plus_txt,'Júlí','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((213+244)/2,minax+plus_txt,'Ágúst','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((244+274)/2,minax+plus_txt,'Sept.','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((274+305)/2,minax+plus_txt,'Okt.','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
%text((305+335)/2,minax+plus_txt,'N�v.','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
%text((335+365)/2,minax+plus_txt,'Des.','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);

title('Hofsjökull Skýjahula: Öll hæðarbil')

text(1,-0.005,'NASA MCD43A3 V006 data / Landsvirkjun Rannsóknir ','Units','normalized','HorizontalAlignment','left','VerticalAlignment','top', 'rotation',90,'color',C,'Fontsize',FS/1.25);
text(1.03,-0.005,['ver. ',datestr(now,'yyyy.mm.dd')],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','top', 'rotation', 90,'color',C,'Fontsize',FS/1.25);
text(0.01,0.99,['Nýjustu gögn: ',datestr(MOD_DATE_NUM)],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','top', 'rotation',0,'color',C,'Fontsize',FS/1.25);

xlim([91 305])
ylim([minax maxax])


fig_name = ['MCD43A3_cc_ho_ts_ver_',datestr(now,'yyyymmdd')]
saveas(fho,fig_name,'png');


% LA
fla =figure(), hold on 
plot(stats.doy,stats.ltm_la,'color','k','Linewidth',1.2)
plot(stats.doy,stats.ltm_la+stats.stdev_la,'color',C,'Linewidth',1.2)
plot(A.doy(xi),Mla(xi),'r','Linewidth',1.3)
plot(A.doy(xii),Mla(xii),'r--')
plot(A.doy(xiii),Mla(xiii),'bl--')

legend('Median','+/- std',num2str(Current_Year),num2str(Last_Year),num2str(Last_Last_Year),'AutoUpdate','off')
plot(stats.doy,stats.ltm_la-stats.stdev_la,'color',C,'Linewidth',1.2)

xlabel('Dagur Ársins')
ylabel('Skýjahula (-)')

plot([31,31],[0,1],'color',C,'LineStyle','--')
plot([60,60],[0,1],'color',C,'LineStyle','--')
plot([91,91],[0,1],'color',C,'LineStyle','--')
plot([121,121],[0,1],'color',C,'LineStyle','--')
plot([152,152],[0,1],'color',C,'LineStyle','--')
plot([182,182],[0,1],'color',C,'LineStyle','--')
plot([213,213],[0,1],'color',C,'LineStyle','--')
plot([244,244],[0,1],'color',C,'LineStyle','--')
plot([274,274],[0,1],'color',C,'LineStyle','--')
plot([305,305],[0,1],'color',C,'LineStyle','--')
plot([335,335],[0,1],'color',C,'LineStyle','--')

%
FS= 12;
plus_txt = 0.01
%text((31)/2,minax+plus_txt,'Jan�ar','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
%text((60+31)/2,minax+plus_txt,'Febr�ar','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
%text((91+60)/2,minax+plus_txt,'Mars','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((91+121)/2,minax+plus_txt,'Apríl','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((121+152)/2,minax+plus_txt,'Maí','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((152+182)/2,minax+plus_txt,'Júní','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((182+213)/2,minax+plus_txt,'Júlí','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((213+244)/2,minax+plus_txt,'Ágúst','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((244+274)/2,minax+plus_txt,'Sept.','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
text((274+305)/2,minax+plus_txt,'Okt.','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
%text((305+335)/2,minax+plus_txt,'N�v.','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);
%text((335+365)/2,minax+plus_txt,'Des.','HorizontalAlignment','left','VerticalAlignment','middle', 'rotation', 90,'color',C,'Fontsize',FS);

title('Langjökull Skýjahula: Öll hæðarbil')

text(1,-0.005,'NASA MCD43A3 V006 data / Landsvirkjun Rannsóknir ','Units','normalized','HorizontalAlignment','left','VerticalAlignment','top', 'rotation',90,'color',C,'Fontsize',FS/1.25);
text(1.03,-0.005,['ver. ',datestr(now,'yyyy.mm.dd')],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','top', 'rotation', 90,'color',C,'Fontsize',FS/1.25);
text(0.01,0.99,['Nýjustu gögn: ',datestr(MOD_DATE_NUM)],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','top', 'rotation',0,'color',C,'Fontsize',FS/1.25);

xlim([91 305])
ylim([minax maxax])


fig_name = ['MCD43A3_cc_la_ts_ver_',datestr(now,'yyyymmdd')]
saveas(fla,fig_name,'png');



















