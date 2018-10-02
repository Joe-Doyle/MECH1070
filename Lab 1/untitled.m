numRot = [10;10;10;10;10;10;60]
dist = [13;13;12;13;13;13;76]
num = [5 7 10]
mmPerRot = [24.08 17.16 12.12]

figure;
a = axes

set(a,'fontsize',18,'fontname','times')
a = plot(num, mmPerRot,'>-')
set(a,'linewidth',2,'color','b','markersize',6)
grid on
a = xlabel('Feed Rate')
set(a,'fontsize',18,'fontname','times')
a = ylabel('time for round trip of block')
set(a,'fontsize',18,'fontname','times')
a = title('Line Plot of feed rate vs time to travel set distance')
set(a,'fontsize',18,'fontname','times')
%axis([1 7 0 2])
print('-dpng','-r300','feedRateVsTime.png')