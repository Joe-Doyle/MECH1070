task=categorical({'sleep','studying/homework','classes','eating','personal projects','other'});
time=[48 40; 20 37; 19 22; 15.75 10.5; 7 11; 58 47];

bar(task,time);
a = xlabel('Activity');
set(a,'fontsize',18,'fontname','times')
a = ylabel('Time in Hours');
set(a,'fontsize',18,'fontname','times')

handle_legend = legend ('Joseph','World Class Engineer');
set(handle_legend, 'location','northwest')
set(handle_legend,'fontsize',18,'fontname','times')
a = title('My Time Vs. The World Class Engineer');
set(a,'fontsize',18,'fontname','times')