/*

let us continue https://www.linkedin.com/pulse/making-decision-optimization-simple-alex-fleischer/

*/


float costBus40=500;
float costBus30=400;
 
dvar int+ nbBus40;
dvar int+ nbBus30;
 
minimize
 costBus40*nbBus40  +nbBus30*costBus30;
 
subject to
{
 285<=40*nbBus40+nbBus30*30<=290;
} 

/*

which gives

nbBus40 = 5;
nbBus30 = 3;

*/
