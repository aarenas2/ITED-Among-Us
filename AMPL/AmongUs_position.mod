# Sets

set N; # All the nodes
set T; # Nodes with tasks
set V; # Nodes visited by the impostor
set P; # Possible positions to visit a node
set N1; # Nodes whitour CafeteriaFinish
set N2; # Nodes whitour CafeteriaStart

# Parameters

param tiempos{N,N}; # Time matrix
param tar{N}; # Times to perform every task
param telleg{V}; # Arrival times of the impostor
param tesal{V}; # Departure times of the impostor


# Variables

var x{N,N} binary; 
var Tau{N} >= 0;
var y{V} binary;
var Q{N,P} binary;

minimize costostotales:
	#sum{i in N, j in N}(tiempos[i,j]*x[i,j])+sum{j in T}tar[j];
	Tau['CafeteriaFinish'];

subject to salirdecadanodo {i in N1}:
	sum{j in N}x[i,j]=1;
	
subject to entraracadanodo {j in N2}:
	sum{i in N}x[i,j]=1;
	
subject to diag:
	sum{i in N}x[i,i]=0;
	
subject to tauact {j in N, i in N1}:
	Tau[i] + tar[i] + tiempos[i,j]*x[i,j] <= Tau[j] + (1-x[i,j])*1000;
	
subject to initialTau:
	Tau['CafeteriaStart'] = 0;
	
subject to antes {j in V}:
	Tau[j]+tar[j] <= telleg[j]+1000*(1-y[j]);
	
subject to desps {j in V}:
	Tau[j] >= tesal[j]*(1-y[j]);
	
subject to onepos {p in P}:
	sum{i in N}Q[i,p] = 1;
	
subject to onevis {i in N}:
	sum{p in P}Q[i,p] = 1;
	
subject to relQandx {i in N, j in N, p in 1..11}:
	1 + x[i,j] >= Q[i,p] + Q[j,p+1]; 
	
subject to noad:
	Q['MedBay',2] = 1;
	
subject to vis1:
	Q['CafeteriaStart',1] = 1;
	
subject to vis2:
	Q['CafeteriaFinish',12] = 1;
	
	
	
	
	
	
	