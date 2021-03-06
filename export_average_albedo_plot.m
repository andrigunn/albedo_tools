
% export_average_albedo_read_txt_for_plotting
% 
% img_dir ='/Volumes/brunnur/brunnur_results/img'
% 
% S = num2str(A.d)
% 
% year = str2num(S(:,1:4))
% doy = str2num(S(:,5:7))
% 
% xi = find(year == 2018)
% xii = find(year == 2017)
% xiii = find(year == 2016)
% 
% window_size = 7
% Mva = movAv(A.Va_alb,window_size)
% Mho = movAv(A.Ho_alb,window_size)
% Mla = movAv(A.La_alb,window_size)
%
A = TS_Glaciers_MCD43A3 ;
%%
for i = 1:365
    x = find(A.doy(:) == i)
    ltm_va  = nanmedian(A.Va_alb(x)) 
    maxx_va = nanmax(A.Va_alb(x)) 
    minn_va = nanmin(A.Va_alb(x))  
    stdev_va = nanstd(A.Va_alb(x))  
    
    stats.doy(i) = i
    stats.ltm_va(i) = ltm_va
    stats.maxx_va(i) = maxx_va
    stats.minn_va(i) = minn_va
    stats.stdev_va(i) = stdev_va
    
    
    ltm_ho  = nanmedian(A.Ho_alb(x)) 
    maxx_ho = nanmax(A.Ho_alb(x)) 
    minn_ho = nanmin(A.Ho_alb(x))  
    stdev_ho = nanstd(A.Ho_alb(x))  
    
    stats.ltm_ho(i) = ltm_ho
    stats.maxx_ho(i) = maxx_ho
    stats.minn_ho(i) = minn_ho
    stats.stdev_ho(i) = stdev_ho
    
    
    ltm_la  = nanmedian(A.La_alb(x)) 
    maxx_la = nanmax(A.La_alb(x)) 
    minn_la = nanmin(A.La_alb(x))  
    stdev_la = nanstd(A.La_alb(x))  
    
    stats.ltm_la(i) = ltm_la
    stats.maxx_la(i) = maxx_la
    stats.minn_la(i) = minn_la
    stats.stdev_la(i) = stdev_la
        
end
%%
close all

fva =figure(), hold on 

C = [192/255 192/255 192/255];
minax = 0.2
maxax = 1

plot(stats.doy,stats.ltm_va,'color','k','Linewidth',1.2)
plot(stats.doy,stats.ltm_va+stats.stdev_va,'color',C,'Linewidth',1.2)
plot(doy(xi),Mva(xi),'r','Linewidth',1.3)
plot(doy(xii),Mva(xii),'r--')
plot(doy(xiii),Mva(xiii),'bl--')

legend('Median','+/- std','2018','2017','2016','AutoUpdate','off')
plot(stats.doy,stats.ltm_va-stats.stdev_va,'color',C,'Linewidth',1.2)

xlabel('Dagur ársins')
ylabel('Endurkastsstuðull (-)')

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

title('Vatnajökull endurkastsstuðull: 0-2100 m y.s.')

text(1,-0.005,'NASA MCD43A3 V006 data / Landsvirkjun Rannsóknir ','Units','normalized','HorizontalAlignment','left','VerticalAlignment','top', 'rotation',90,'color',C,'Fontsize',FS/1.25);
text(1.03,-0.005,['ver. ',datestr(now,'yyyy.mm.dd')],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','top', 'rotation', 90,'color',C,'Fontsize',FS/1.25);

xlim([91 305])
ylim([minax maxax])

cd(img_dir)
fig_name = ['MCD43A3_alb_va_ts_ver_',datestr(now,'yyyymmdd')]
saveas(fva,fig_name,'png');
% cd('\\LVVMVEF02\brunnur$\daily_export_img\mcd43a3\mcd43a3_overall')
% fig_name = ['MCD43A3_alb_va_ts']
% saveas(fva,fig_name,'png');


% HO
fho =figure(), hold on 
plot(stats.doy,stats.ltm_ho,'color','k','Linewidth',1.2)
plot(stats.doy,stats.ltm_ho+stats.stdev_ho,'color',C,'Linewidth',1.2)
plot(doy(xi),Mho(xi),'r','Linewidth',1.3)
plot(doy(xii),Mho(xii),'r--')
plot(doy(xiii),Mho(xiii),'bl--')

legend('Median','+/- std','2017','2016','2015','AutoUpdate','off')
plot(stats.doy,stats.ltm_ho-stats.stdev_ho,'color',C,'Linewidth',1.2)

xlabel('Dagur Ársins')
ylabel('Endurkastsstuðull (-)')

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

title('Hofsjökull Endurkastsstuðull: Öll hæðarbil')

text(1,-0.005,'NASA MCD43A3 V006 data / Landsvirkjun Rannsóknir ','Units','normalized','HorizontalAlignment','left','VerticalAlignment','top', 'rotation',90,'color',C,'Fontsize',FS/1.25);
text(1.03,-0.005,['ver. ',datestr(now,'yyyy.mm.dd')],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','top', 'rotation', 90,'color',C,'Fontsize',FS/1.25);

xlim([91 305])
ylim([minax maxax])


fig_name = ['MCD43A3_alb_ho_ts_ver_',datestr(now,'yyyymmdd')]
saveas(fho,fig_name,'png');
% cd('\\LVVMVEF02\brunnur$\daily_export_img\mcd43a3\mcd43a3_overall')
% fig_name = ['MCD43A3_alb_ho_ts']
% saveas(fho,fig_name,'png');

% LA
fla =figure(), hold on 
plot(stats.doy,stats.ltm_la,'color','k','Linewidth',1.2)
plot(stats.doy,stats.ltm_la+stats.stdev_la,'color',C,'Linewidth',1.2)
plot(doy(xi),Mla(xi),'r','Linewidth',1.3)
plot(doy(xii),Mla(xii),'r--')
plot(doy(xiii),Mla(xiii),'bl--')

legend('Median','+/- std','2017','2016','2015','AutoUpdate','off')
plot(stats.doy,stats.ltm_la-stats.stdev_la,'color',C,'Linewidth',1.2)

xlabel('Dagur Ársins')
ylabel('Endurkastsstuðull (-)')

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

title('Langjökull Endurkastsstuðull: Öll hæðarbil')

text(1,-0.005,'NASA MCD43A3 V006 data / Landsvirkjun Rannsóknir ','Units','normalized','HorizontalAlignment','left','VerticalAlignment','top', 'rotation',90,'color',C,'Fontsize',FS/1.25);
text(1.03,-0.005,['ver. ',datestr(now,'yyyy.mm.dd')],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','top', 'rotation', 90,'color',C,'Fontsize',FS/1.25);

xlim([91 305])
ylim([minax maxax])


fig_name = ['MCD43A3_alb_la_ts_ver_',datestr(now,'yyyymmdd')]
saveas(fla,fig_name,'png');
 
% cd('\\LVVMVEF02\brunnur$\daily_export_img\mcd43a3\mcd43a3_overall')
% fig_name = ['MCD43A3_alb_la_ts']
% saveas(fla,fig_name,'png');