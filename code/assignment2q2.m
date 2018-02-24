nx=75; %length
ny=50; %width

g=sparse(nx*ny);
b=zeros(1,nx*ny);

for i = 1:nx
    for j=1:ny
        n=j+(i-1)*ny;
        if i==1
            g(n,:)=0;
            g(n,n)=1;
            b(n)=1;
        elseif i==nx
            g(n,:)=0;
            g(n,n)=1;
            b(n)=1;
        elseif j==1 
            g(n,n)=1;
            %g(n,n+1)=1;
            %g(n,n-1)=1;
            %g(n,n+ny)=1;
            %g(n,n-ny)=1;
            
        elseif j==ny            
            g(n,n)=1;
            %g(n,n+1)=1;
            %g(n,n-1)=1;
            %g(n,n+ny)=1;
            %g(n,n-ny)=1;    
            
        else %bulk node
            g(n,n)=-4;
            g(n,n+1)=1;
            g(n,n-1)=1;
            g(n,n+ny)=1;
            g(n,n-ny)=1;
        end    
    end
end
%spy(g)

E=g\b';
%spy(E)

d=zeros(nx,ny);
for i = 1:nx
    for j=1:ny
       n=j+(i-1)*ny; 
       d(i,j)=E(n);
       
    end
end


figure(1)
surf(d)
xlabel('Width')
ylabel('Length')
title('Calculated Surface plot of V with 1B boundary conditions')
view(-60,37)
%plot analytical solution

y=0:ny;
x=-(nx+1)/2:(nx-1)/2; %theoretical solution occurs from -x to x
[vx,vy]=meshgrid(x,y); 

f=4/pi*cosh(pi*vx/ny)/cosh(pi*(nx+1)/2/ny).*sin(pi*vy/ny);

 for n=3:2:100   
     f=f+(4/pi)*(1/n)*cosh(n*pi*vx/ny)/cosh(n*pi*(nx+1)/2/ny).*sin(n*pi*vy/ny);
 end 
 
figure(2)
surf(vy,vx+38,f)

view(-60,37)
xlabel('Width')
ylabel('Length')
title('Analytical Surface plot of V with 1B boundary conditions')







