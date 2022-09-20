/*

SOS1 does not exist in OPL but we can write that with logical constraints

*/

int nbKids=300;
float costBus40=500;
float costBus30=400;
 
dvar int+ nbBus40;
dvar int+ nbBus30;
 
minimize
 costBus40*nbBus40  +nbBus30*costBus30;
 
subject to
{
 40*nbBus40+nbBus30*30>=nbKids;
 
 // SOS1
 (nbBus40>=1)+(nbBus30>=1)<=1;
} 

/*

gives

nbBus40 = 8;
nbBus30 = 0;

*/