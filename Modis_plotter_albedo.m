function Modis_plotter_albedo(data,geo,date_data,img_dir)   
%%
close all
        vis = 'off';

        latlimit = [63.9 65.0];
        lonlimit = [-20.7 -15.2];
        
% if ismac
%     addpath('/Users/andrigun/Dropbox/Matlab/cbrewer');
% elseif ispc
%     addpath('E:\Dropbox\Matlab\cbrewer');
% end        
        
f = figure( 'visible',vis,'Position', [50, 100, 900, 600]);
    axesm('MapProjection','mercator','MapLatLimit',latlimit,'MapLonLimit',lonlimit);
    hold on 
    lw = 0.1;
        
            h = pcolorm(geo.lat,geo.lon,data);
            shading flat;
            fillm([geo.utlina_isl(4524).Y],[geo.utlina_isl(4524).X], 'FaceColor',[224/255 224/255 224/255],'linewidth',lw);
            fillm([geo.utlina_vat.Y],[geo.utlina_vat.X], 'w','linewidth',lw);
            fillm([geo.utlina_hof.Y],[geo.utlina_hof.X], 'w','linewidth',lw);
            fillm([geo.utlina_lan.Y],[geo.utlina_lan.X], 'w','linewidth',lw);
            uistack(h,'top');
            plotm([geo.utlina_isl(4524).Y],[geo.utlina_isl(4524).X], 'k','linewidth',lw);
            plotm([geo.utlina_vat.Y],[geo.utlina_vat.X], 'k','linewidth',lw);
            plotm([geo.utlina_hof.Y],[geo.utlina_hof.X], 'k','linewidth',lw);
            plotm([geo.utlina_lan.Y],[geo.utlina_lan.X], 'k','linewidth',lw);
            caxis([0 1]);
            hb=colorbar;
            %cmap = cbrewer('seq','Greys',100)
            %parula
            colormap%(flipud(cmap))
            ylabel(hb, 'Albedo');
            set(hb,'FontSize',16);
            tightmap;
            box off;
            ax = gca;
            ax.Visible = 'off';
            hText = text(0.01,1.0,date_data,'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',24);
       
             print(f,[img_dir,'/','MCD43_',date_data(end-6:end)],'-dpng','-r0')
