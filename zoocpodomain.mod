// Now suppose we can rent only 0,1,3,4 or 5 buses of 40 seats buses

using CP;


int nbKids=300;
float costBus40=500;
float costBus30=400;

{int} allowedQuantities={0,1,3,4,5};
 
dvar int+ nbBus40;
dvar int+ nbBus30;
 
minimize
 costBus40*nbBus40  +nbBus30*costBus30;
 
subject to
{
 40*nbBus40+nbBus30*30>=nbKids;
 
 nbBus40 in allowedQuantities;
} 

/*

which gives

nbBus40 = 3;
nbBus30 = 6;

*/


