using CP;

// CPOptimizer allows all kind of non linearities

int nbKids=300;
float costBus40=500;
float costBus30=400;
 
dvar int+ nbBus40;
dvar int+ nbBus30;
 
// Non linear objective (exponential) 
minimize
 costBus40*exp(nbBus40) +exp(nbBus30)*costBus30;
 
subject to
{
 40*nbBus40+nbBus30*30>=nbKids;
} 

/*

gives

nbBus40 = 4;
nbBus30 = 5;

*/
