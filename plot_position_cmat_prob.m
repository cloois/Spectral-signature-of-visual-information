function plot_position_cmat_prob(poss,cmat)

method = 'nearest'; % linear, cubic, v4, nearest, natural
resolution = 0.1;
smooth = 'n';
mark = 'y';
circles = 'n';
lim = 'maxabs';

[XI YI] = meshgrid(-1:resolution:6, -6:resolution:1);    
perf = diag(cmat)./squeeze(sum(cmat'))';
tri = TriScatteredInterp(poss(:,1),poss(:,2),perf,method);
ZI = tri(XI,YI);

if strcmp(smooth,'y')
    %ret = customgauss([10 10],8,8,0,0,1,[0 0]);
    ret = fspecial('gaussian',[10 10]);
    ZI = conv2(ZI,ret,'same');
end

    surface(XI,YI,ZI)
  
    alpha(double(ZI>(1/60)))
    
    axis([-5 10 -6 1])
    grid on
    shading flat
    
    cb=caxis;
    if strcmp(lim,'maxabs')
       l = max(abs(cb));
       caxis([l*-1 l])
    else
        caxis(lim)
    end
    
    %axis off
    C= NaN;
    h=NaN;
    
if strcmp(mark,'y')
    hold on
    %plot(x,y,'ko','MarkerSize',4)
    plot3(poss(:,1),poss(:,2),ones(60,1)*100,'k*')
end
if strcmp(circles,'y')
    hold on
    RF_mapping_figure(poss)
end
hold off