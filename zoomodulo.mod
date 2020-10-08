/*

let us continue https://www.linkedin.com/pulse/making-decision-optimization-simple-alex-fleischer/

*/

int nbKids=300;
float costBus40=500;
float costBus30=400;
 
dvar int+ nbBus40;
dvar int+ nbBus30;

dvar int+ nbBus40div3;
dvar int+ nbBus30div3;
 
minimize
 costBus40*nbBus40  +nbBus30*costBus30;
 
subject to
{
 40*nbBus40+nbBus30*30>=nbKids;
 
 // Plus let s add that numbers of buses have to be 3 multipliers
 
 nbBus40==3*nbBus40div3;
 nbBus30==3*nbBus30div3;
 
 
} 

/*

which gives

nbBus40 = 3;
nbBus30 = 6;

*/
