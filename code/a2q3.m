%  q2device (resistivity high,resistivity low,left,right,bottom,top,nx,ny,plot)

current = q2device(1,1e-2,25,50,15,35,75,50,1);

%section break

current=zeros(1,100);
for i = 1:100
    ny=15+(i);
    nx=round(ny*3/2);
    current(i)=q2device(1,1e-2,round(nx/3),round(2*nx/3),round(3/10*ny),round(7/10*ny),nx,ny,0);
end

x=linspace(1,100);
figure(1)
plot (x,current)
xlabel('mesh size (# of divisions of 1mm)')
ylabel('current (A)')
title('current vs. mesh size')

% Here the current decreases with mesh size.  Since the mesh size is very
% large at the begining of the graph, it is innaccurate, and gives a poor
% estimation of current.  As the mesh size increases, the predicted value
% approaches the true value.  It will reach an asymtote as the predicted
% value approaches the real value.

%current vs.  increasing width of the Bottle Necks
current=0;
j=0;
for i = 0:15
    j=j+1;
    ny=50;
    nx=75;
    current(j)=q2device(1,1e-2,25,50,round(5+i),round(45-i),nx,ny,0);
end

x=linspace(40,10,length(0:15));
figure(2)
plot (x,current)
xlabel('width of central conductive region')
ylabel('current (A)')
title('current vs. bottleneck width')
view(0,90)

% Here the current increases as the width of the conductive channel
% increases.  This is expected because resistance is inversly proportional
% to width, so a higher width as a lower resistance, and therefore more
% current will flow


%current vs.  increasing conductivity
j=0;
current=0;
for i = 0.2:.04:0.9
    j=j+1;
    ny=100;
    nx=150;
    current(j)=q2device(i,i/100,50,100,30,70,nx,ny,0);
end
x= 0.2:.04:0.9;
figure(3)
plot (x,current)
xlabel('conductivity of the higher conductivity region')
ylabel('current (A)')
title('current vs.conductivity while \sigma_1=100*\sigma_2')