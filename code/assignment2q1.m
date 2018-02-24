nx=75; %length of box
ny=50; %width of box

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
        elseif j==1 
            g(n,n)=-3;
            g(n,n+1)=1;
            g(n,n-1)=1;
            g(n,n+ny)=1;
            %g(n,n-ny)=1;
            
        elseif j==ny            
            g(n,n)=-3;
            g(n,n+1)=1;
            g(n,n-1)=1;
            %g(n,n+ny)=1;
            g(n,n-ny)=1;    
            
        else %bulk node
            g(n,n)=-4;
            g(n,n+1)=1;
            g(n,n-1)=1;
            g(n,n+ny)=1;
            g(n,n-ny)=1;
        end    
    end
end
spy(g)

E=g\b';
%spy(E)


d=zeros(nx,ny);
for i = 1:nx
    for j=1:ny
       n=j+(i-1)*ny; 
       d(i,j)=E(n);       
    end
end
surf(d)
xlabel('Width')
ylabel('Length')

