# Definir sets

set N; # Todos los nodos
set T; # Nodos con tareas
set V; # Nodos que visita el impostor

# Parámetros

param tiempos{N,N}; # Matriz de costos
param tar{N}; # Tiempo para hacer la tarea
param telleg{V}; # Tiempo de llegada impostor
param tesal{V}; # Tiempo de salida impostor


# Variables

var x{N,N} binary; 
var F{N,N} >= 0;
var Z{V} binary;

minimize costostotales:
	#sum{i in N, j in N}(tiempos[i,j]*x[i,j])+sum{j in T}tar[j];
	sum{i in N}F[i,'Cafeteria'];

subject to salirdecadanodo {i in N}:
	sum{j in N}x[i,j]=1;
	
subject to entraracadanodo {j in N}:
	sum{i in N}x[i,j]=1;
	
subject to diag:
	sum{i in N}x[i,i]=0;
	
subject to flujodep:
	sum{j in T}F['Cafeteria',j]=sum{j in T}(tiempos['Cafeteria',j]*x['Cafeteria',j]);
	
subject to equivalencia {i in T}:
	sum{j in N}(F[j,i]+tiempos[i,j]*x[i,j])+tar[i]<=sum{j in N}F[i,j];

subject to flujosolousarconarco {i in N, j in N}:
	F[i,j] <= 1000*x[i,j];
	
subject to antes {j in V}:
	sum{i in N}F[i,j]+tar[j] <= telleg[j]+1000*(1-Z[j]);
	
subject to desps {j in V}:
	sum{i in N}F[i,j] >= tesal[j]*(1-Z[j]);
	
subject to noad:
	x['Cafeteria','MedBay'] = 1;
	
	
	
	
	
	
	
	
	