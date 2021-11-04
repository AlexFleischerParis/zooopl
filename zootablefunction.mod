using CP;

// CPOptimizer allows all kind of non linearities and even 
// functions in table

int nbKids=300;
range rangeBus=0..10; // You may order 0 to 10 buses of each size

float costBus40[rangeBus]=[0,500,995,1480,1900,2350,2750,3100,3520,3900,4200];
float costBus30[rangeBus]=[0,400,780,1180,1570,1960,2350,2650,2950,3200,3600];
 
dvar int+ nbBus40;
dvar int+ nbBus30;
 
// function in a table
minimize
 costBus40[nbBus40] +costBus30[nbBus30];
 
subject to
{
 40*nbBus40+nbBus30*30>=nbKids;
} 

assert 
costBus40[nbBus40] +costBus30[nbBus30]==
element(costBus40,nbBus40)+element(costBus30,nbBus30);

/*
gives
nbBus40 = 7;
nbBus30 = 1;
*/
