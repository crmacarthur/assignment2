function [curr]=q2device(res1,res2,left,right,bottom,top,nx,ny,plot)
nx; %length
ny; %width

g=sparse(nx*ny);
b=zeros(1,nx*ny);

sig1=res1;
sig2=res2;

% box = [ left right bottom top] of center high conductive region
box=[left right bottom top];

sigma=zeros(nx,ny);
for i = 1:nx
    for j=1:ny
        
        if i > box(1) && i < box(2) &&j >box(4) %upper box - low cond
            sigma(i,j)=sig2;
        elseif i > box(1) && i < box(2) &&j <box(3) %lower box - low cond
            sigma(i,j)=sig2;
        else %high cond
            sigma(i,j)=sig1;
        end
    end
end

for i = 1:nx
    for j=1:ny
        n=j+(i-1)*ny;
        if i==1  %left
            g(n,:)=0;
            g(n,n)=1;
            b(n)=1;
        elseif i==nx %right
            g(n,:)=0;
            g(n,n)=1;
            
        elseif j==1 %bottom 
            up=(sigma(i,j)+sigma(i,j+1))/2;
            left=(sigma(i,j)+sigma(i-1,j))/2;
            right=(sigma(i,j)+sigma(i+1,j))/2;
            g(n,n)=-(up+left+right);
            g(n,n+1)=up;
            g(n,n-ny)=left;
            g(n,n+ny)=right;

        elseif j==ny %top         
            %low conductivity 
            down=(sigma(i,j)+sigma(i,j-1))/2;
            left=(sigma(i,j)+sigma(i-1,j))/2;
            right=(sigma(i,j)+sigma(i+1,j))/2;
            
            g(n,n)=-(up+left+right);
            g(n,n+ny)=right;
            g(n,n-1)=down;
            g(n,n-ny)=left;

            
        else %bulk node
            
            down=(sigma(i,j)+sigma(i,j-1))/2;
            left=(sigma(i,j)+sigma(i-1,j))/2;
            right=(sigma(i,j)+sigma(i+1,j))/2;
            up=(sigma(i,j)+sigma(i,j+1))/2;            
            
            g(n,n)=-(up+down+right+left);
            g(n,n+1)=up;
            g(n,n-1)=down;
            g(n,n+ny)=right;
            g(n,n-ny)=left;

        end
    end    
end



E=g\b';

d=zeros(nx,ny);
for i = 1:nx
    for j=1:ny
       n=j+(i-1)*ny; 
       d(i,j)=E(n);
       
    end
end
if plot
    figure(1)
    surf(d) %V(x,y)
    xlabel('Width')
    ylabel('Length')
    title('V(x,y)')
    view(-256,36)
end

%make sigma(x,y) graph


if plot
    figure(2)
    surf(sigma) %sigma(x,y)
    xlabel('Width')
    ylabel('Length')
    title('Sigma(x,y)')
    view(0,90)
end

[ex,ey]=gradient(d);
ex=-ex;
ey=-ey;
if plot
    figure(3) %E(x,y)
    quiver(ex,ey)
    xlabel('Width')
    ylabel('Length')
    title('E(x,y)')
end

Jx = ex.*sigma;
Jy = ey.*sigma;
if plot
    figure(4)
    quiver(Jx,Jy)
    xlabel('Width')
    ylabel('Length')
    title('J(x,y)')
end



%find current between the two contacts (assuming they are on the right and
%left side of the device. also assume the device is 1mmx1mm)

curr=0;
for j=1:ny
    %current = current + current_density * area of 1 element
    curr=curr+Jy(1,j)*(1e-3/ny);
end
end
