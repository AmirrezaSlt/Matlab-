bubble_point
dewpoint_cal
for i=1:1:100
    plot(T_dew(1:i),p_dew(1:i),'.-g');
    hold on
    plot(T_bubble(1:i),p_bubble(1:i),'...b'); 
    hold on
    plot(T_bubble(end),p_bubble(end),'og');
    xlim([T_bubble(1)-100,T_bubble(end)+100])
    ylim([0,2300]);
    drawnow
end
legend('Dew curve','Bubble curve','Critical point')