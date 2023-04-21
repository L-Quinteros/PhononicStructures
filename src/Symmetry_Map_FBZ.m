

function [MAP]=Symmetry_Map_FBZ(n,type)

  if type == 1
      n2 = (n/2);
      barnumber = (n*(n+1))+(n*(n+1))+2*n*n;
      varnumber = (2*n2*(n2+1));
      MAP = zeros(barnumber,varnumber); 


      %----- Primer cuadrante 
      %Barras horizontales
      k = 1;
      number=1;
      for j =1:n2
        for i = number:n2
          MAP(i+n*(j-1),k) = 1 ;
          k=k+1;
        end
        number=number+1;  
      end
      %Barras Verticales
      number=1;
      for j =1:n2
        for i = number:n2
          MAP(n*(n+1)+1+i+(j-1)*(n+1),k) = 1; 
          k=k+1;
        end  
        number=number+1 ;
      end
      %inclinadas /
      number=1;
      for j =1:n2
        for i = number:n2
          MAP(2*n*(n+1)+i+(j-1)*n,k) = 1 ;
          k=k+1;
        end  
        number=number+1 ;
      end

      %Inclinadas \
      number=1;
      for j =1:n2
        for i = number:n2
          MAP(2*n*(n+1)+n*n+i+(j-1)*n,k) = 1 ;
          k=k+1;
        end  
        number=number+1 ;
      end

      %------ Segundo cuadrante
      %Barras horizontales _
      k = 1;
      number = 1;
      for j =1:n2
        for i = number:n2
          MAP(n+1-i+n*(j-1),k) = 1;
          k=k+1  ;
        end
        number=number+1   ;
      end

      %Barras Verticales |
      number = 1;
      for j =1:n2
        for i = number:n2
          MAP(n*(n+1)+n+1-i+(j-1)*(n+1),k) = 1;
          k=k+1  ;
        end 
        number=number+1  ; 
      end

      %inclinadas /
      number=1;
      for j =1:n2
        for i = number:n2
          MAP(2*n*(n+1)+n*n+n+(1-i)+(j-1)*n,k) = 1 ;
          k=k+1;
        end  
        number=number+1 ;
      end

      %Inclinadas \
      number=1;
      for j =1:n2
        for i = number:n2
          MAP(2*n*(n+1)+n+(1-i)+(j-1)*n,k) = 1; 
          k=k+1;
        end  
        number=number+1 ;
      end

      %------ Tercer cuadrante
      %Barras horizontales _
      k = 1;
      number = 1;
      for j =1:n2
        for i = number:n2
          MAP(n*(n+1) + (i)*(n+1)+1-j,k) = 1;
          k=k+1 ; 
        end
        number=number+1   ;
      end

      %Barras Verticales |
      number = 1;
      for j =1:n2
        for i = number:n2
          MAP(n+n+1-j+(i-1)*n,k) = 1;
          k=k+1  ;
        end 
        number=number+1   ;
      end


      %inclinadas /
      number=1;
      for j =1:n2
        for i = number:n2
          MAP(2*n*(n+1)+n*n+n+(i-1)*n+(1-j),k) = 1 ;
          k=k+1;
        end  
        number=number+1 ;
      end

      %Inclinadas \
      number=1;
      for j =1:n2
        for i = number:n2
          MAP(2*n*(n+1)+n+(i-1)*n+(1-j),k) = 1; 
          k=k+1;
        end  
        number=number+1 ;
      end

      %------ Cuarto cuadrante
      %Barras horizontales _
      k = 1;
      number = 1;
      for j =1:n2
        for i = number:n2
          MAP(n*(n+1)+n*(n+1)+(1-j)+(1-i)*(n+1),k) = 1;
          k=k+1  ;
        end
        number=number+1   ;
      end

      %Barras Verticales |
      number    = 1;
      for j =1:n2
        for i = number:n2
          MAP(n*n+(1-i)*n+(1-j),k) = 1;
          k=k+1  ;
        end 
        number=number+1;   
      end

      %inclinadas /
      number=1;
      for j =1:n2
        for i = number:n2
          MAP(2*n*(n+1)+n*n+(1-i)*n+(1-j),k) = 1 ;
          k=k+1;
        end  
        number=number+1 ;
      end

      %Inclinadas \
      number=1;
      for j =1:n2
        for i = number:n2
          MAP(2*n*(n+1)+2*n*n+(1-i)*n+(1-j),k) = 1; 
          k=k+1;
        end  
        number=number+1 ;
      end

      %------ Quinto cuadrante
      %Barras horizontales _
      k = 1;
      number = 1;
      for j =1:n2
        for i = number:n2
          MAP(n*(n+1)+(1-i)+(1-j)*n,k) = 1;
          k=k+1;  
        end
        number=number+1;   
      end

      %Barras Verticales |
      number = 1;
      for j =1:n2
        for i = number:n2
          MAP(n*(n+1)+n*(n+1)+(-i)+(1-j)*(n+1),k) = 1;
          k=k+1;  
        end 
        number=number+1;   
      end

      %inclinadas /
      number=1;
      for j =1:n2
        for i = number:n2
          MAP(2*n*(n+1)+n*n+(1-i)+(1-j)*n,k) = 1; 
          k=k+1;
        end  
        number=number+1; 
      end

      %Inclinadas \
      number=1;
      for j =1:n2
        for i = number:n2
          MAP(2*n*(n+1)+2*n*n+(1-i)+(1-j)*n,k) = 1; 
          k=k+1;
        end  
        number=number+1; 
      end

      %------ Sexto cuadrante
      %Barras horizontales _
      k = 1;
      number = 1;
      for j =1:n2
        for i = number:n2
          MAP(n*n+i+(1-j)*n,k) = 1;
          k=k+1;  
        end
        number=number+1;   
      end

      %Barras Verticales |
      number = 1;
      for j =1:n2
        for i = number:n2
          MAP(n*(n+1)+n*(n+1)-n+i+(1-j)*(n+1),k) = 1;
          k=k+1;  
        end 
        number=number+1;   
      end
      %inclinadas /
      number=1;
      for j =1:n2
        for i = number:n2
          MAP(2*n*(n+1)+2*n*n-n+i+(1-j)*n,k) = 1; 
          k=k+1;
        end  
        number=number+1 ;
      end

      %Inclinadas \
      number=1;
      for j =1:n2
        for i = number:n2
          MAP(2*n*(n+1)+n*n-n+i+(1-j)*n,k) = 1 ;
          k=k+1;
        end  
        number=number+1 ;
      end

      %------ Septimo cuadrante
      %Barras horizontales _
      k = 1;
      number = 1;
      for j =1:n2
        for i = number:n2
          MAP(n*n+n*(n+1)+(1-i)*(n+1)+(j-1),k) = 1;
          k=k+1  ;
        end
        number=number+1;   
      end

      %Barras Verticales |
      number = 1;
      for j =1:n2
        for i = number:n2
          MAP(n*(n-1)+(1-i)*n+j,k) = 1;
          k=k+1  ;
        end 
        number=number+1;   
      end

      %inclinadas /
      number=1;
      for j =1:n2
        for i = number:n2
          MAP(2*n*(n+1)+2*n*n-n+(1-i)*n+j,k) = 1; 
          k=k+1;
        end  
        number=number+1; 
      end

      %Inclinadas \
      number=1;
      for j =1:n2
        for i = number:n2
          MAP(2*n*(n+1)+n*n-n+(1-i)*n+j,k) = 1; 
          k=k+1;
        end  
        number=number+1 ;
      end

      %------ Octavo cuadrante
      %Barras horizontales _
      k = 1;
      number = 1;
      for j =1:n2
        for i = number:n2
          MAP(n*(n+1)+(i-1)*(n+1)+j,k) = 1;
          k=k+1  ;
        end
        number=number+1;   
      end

      %Barras Verticales |
      number = 1;
      for j =1:n2
        for i = number:n2
          MAP(n+(i-1)*(n)+j,k) = 1;
          k=k+1  ;
        end 
        number=number+1;   
      end

      %inclinadas /
      number=1;
      for j =1:n2
        for i = number:n2
          MAP(2*n*(n+1)+j+(i-1)*n,k) = 1 ;
          k=k+1;
        end  
        number=number+1; 
      end

      %Inclinadas \
      number=1;
      for j =1:n2
        for i = number:n2
          MAP(2*n*(n+1)+n*n+j+(i-1)*n,k) = 1 ;
          k=k+1;
        end  
        number=number+1; 
      end
  elseif type ==2
    ref = 1;
    %Supose that nx = ny always
	nc = n;
	nnc = nc*ref+1;
	%Total number of element
	hb = (n+1)*(n*ref);
	hv = (n+1)*(n*ref);
	numele = hb+hv;

	%Number of reduce variables

	Reduce_hb = ((n/2)*((n/2)+1)/2);
	Reduce_vb = ((n/2)*((n/2)+1)/2);
	Reduce_numele = Reduce_vb+Reduce_hb;	

	sym_matrix = zeros(numele,Reduce_numele);
	%FinalM=zeros(numele,Reduce_numele)

	%element_e = 1
	% 1. horizontal, vertical and outplane bars
	% 1.1. Horizontal bars
    hs=nc/2;
	for z = 1:1
		number = 1;
		index  = 0;
        index2 = (n+1)*(n*ref);
	   	k=number;p=1;
	   	% cuadrante 1
	    for j = 1:hs
	        for i = p:hs
	         	for m = 1:ref	         
	               	sym_matrix((1+(m-1)+(i-1)*ref+(j-1)*(nc*ref)+index),(k)) = 1;
	            end 
	            k=k+1;
	        end 
	        p=p+1;
	    end 
	   	k=number;p=1;
	   	% cuadrante 2
	    for j = 1:hs
	        for i = p:hs
	         	for m = 1:ref	         
	               	sym_matrix((n*ref-(m-1)-(i-1)*ref+(j-1)*(nc*ref)+index),(k)) = 1;
	            end 
	            k=k+1;
	        end 
	        p=p+1;
	    end 
	    
	    % cuadrante 3
	    k=number;p=1;
	    for j = 1:hs
	        for i = p:hs
	         	for m = 1:ref	         
	               	sym_matrix((n+1+(m-1)*(n+1)+(i-1)*ref*(n+1)-(j-1)+index2),(k)) = 1;
	            end 
	            k=k+1;
	        end 
	        p=p+1;
	    end 

	    % cuadrante 4
	    k=number;p=1;
	    for j = 1:hs
	        for i = p:hs
	         	for m = 1:ref	         
	               	sym_matrix(((n*ref)*(n+1)-(m-1)*(n+1)-(i-1)*ref*(n+1)-(j-1)+index2),(k)) = 1;
	            end 
	            k=k+1;
	        end 
	        p=p+1;
	    end

	    k=number;p=1;
	   	% cuadrante 5
	    for j = 1:hs
	        for i = p:hs
	         	for m = 1:ref	         
	               	sym_matrix(((n*ref)*(n+1)-(m-1)-(i-1)*ref-(j-1)*(nc*ref)+index),(k)) = 1;
	            end 
	            k=k+1;
	        end 
	        p=p+1;
	    end 
	    k=number;p=1;
	    % cuadrante 6
	    for j = 1:hs
	        for i = p:hs
	         	for m = 1:ref	         
	               	sym_matrix(((n*ref)*(n)+1+(m-1)+(i-1)*ref-(j-1)*(nc*ref)+index),(k)) = 1;
	            end 
	            k=k+1;
	        end 
	        p=p+1;
	    end 
	    % cuadrante 7
	    k=number;p=1;
	    for j = 1:hs
	        for i = p:hs
	         	for m = 1:ref	         
	               	sym_matrix(((n*ref-1)*(n+1)+1-(m-1)*(n+1)-(i-1)*ref*(n+1)+(j-1)+index2),(k)) = 1;
	            end 
	            k=k+1;
	        end 
	        p=p+1;
	    end

	    % cuadrante 8
	    k=number;p=1;
	    for j = 1:hs
	        for i = p:hs
	         	for m = 1:ref	         
	               	sym_matrix((1+(m-1)*(n+1)+(i-1)*ref*(n+1)+(j-1)+index2),(k)) = 1;
	            end 
	            k=k+1;
	        end 
	        p=p+1;
	    end
	end 
	% 1.2 vertical bars 
	for z = 1:1
		number = ((n/2)*((n/2)+1)/2)+1;
		index  = 0;
        index2 = (n+1)*(n*ref);
	   	

	   	% cuadrante 1
	   	k=number;p=1;
	    for j = 1:hs
	        for i = p:hs
	         	for m = 1:ref	         
	               	sym_matrix((2+(m-1)*(n+1)+(i-1)+(j-1)*ref*(n+1)+index2),(k)) = 1;
	            end 
	            k=k+1;
	        end 
	        p=p+1;
	    end 

	    % cuadrante 2
	   	k=number;p=1;
	    for j = 1:hs
	        for i = p:hs
	         	for m = 1:ref	         
	               	sym_matrix(((n)+(m-1)*(n+1)-(i-1)+(j-1)*ref*(n+1)+index2),(k)) = 1;
	            end 
	            k=k+1;
	        end 
	        p=p+1;
	    end 
	    % cuadrante 3
	   	k=number;p=1;
	    for j = 1:hs
	        for i = p:hs
	         	for m = 1:ref	         
	               	sym_matrix((1+n*ref+i*(n*ref)-m-(j-1)*ref+index),(k)) = 1;
	            end 
	            k=k+1;
	        end 
	        p=p+1;
	    end 
	    % cuadrante 4
	   	k=number;p=1;
	    for j = 1:hs
	        for i = p:hs
	         	for m = 1:ref	         
	               	sym_matrix((1+(n*ref)*(n+1)-i*(n*ref)-m-(j-1)*ref+index),(k)) = 1;
	            end 
	            k=k+1;
	        end 
	        p=p+1;
	    end
	    % cuadrante 5
	   	k=number;p=1;
	    for j = 1:hs
	        for i = p:hs
	         	for m = 1:ref	         
	               	sym_matrix(((n+1)*(ref*n)-1-(m-1)*(n+1)-(i-1)-(j-1)*ref*(n+1)+index2),(k)) = 1;
	            end 
	            k=k+1;
	        end 
	        p=p+1;
	    end
	    % cuadrante 6
	   	k=number;p=1;
	    for j = 1:hs
	        for i = p:hs
	         	for m = 1:ref	         
	               	sym_matrix(((n+1)*(ref*n)-(n-1)-(m-1)*(n+1)+(i-1)-(j-1)*ref*(n+1)+index2),(k)) = 1;
	            end 
	            k=k+1;
	        end 
	        p=p+1;
	    end
	     % cuadrante 7
	   	k=number;p=1;
	    for j = 1:hs
	        for i = p:hs
	         	for m = 1:ref	         
	               	sym_matrix(((n*ref)*(n-1)-(i-1)*(n*ref)+m+(j-1)*ref+index),(k)) = 1;
	            end 
	            k=k+1;
	        end 
	        p=p+1;
	    end

	    % cuadrante 8
	   	k=number;p=1;
	    for j = 1:hs
	        for i = p:hs
	         	for m = 1:ref	         
	               	sym_matrix((n*ref+(i-1)*(n*ref)+m+(j-1)*ref+index),(k)) = 1;
	            end 
	            k=k+1;
	        end 
	        p=p+1;
	    end 
	end  	
      
      MAP = sym_matrix;
      
  end 


end