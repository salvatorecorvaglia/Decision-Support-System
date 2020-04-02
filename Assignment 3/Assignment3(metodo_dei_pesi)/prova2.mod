set attivita; 
param b{attivita} >= 0; #durata minima attivit�
param D{attivita} >= 0; #Durata massima attivit�
param a{attivita} >= 0; #coeff. per unit� di tempo/$
param p{i in attivita, j in attivita}, binary;
param extrabudget;
param A;
var S{attivita} >= 0; #tempo inizio attivit�
var d{attivita} >= 0; #durata attivit� i-esima
var X{attivita} <= extrabudget, >= 0; # budget per accelerare l'attivit� i-esima
var T >= 0; #durata progetto


minimize my_objective: A * (sum{i in attivita} X[i]) + (1 - A) * T;

s.t. vincolo1{i in attivita}: T >= S[i] + d[i];
s.t. vincolo2{i in attivita, j in attivita}: S[i] >= p[i,j] * (S[j] + d[j]);
s.t. vincolo3{i in attivita}: d[i] >= b[i];
s.t. vincolo4{i in attivita}: d[i] = D[i] - a[i] * X[i];