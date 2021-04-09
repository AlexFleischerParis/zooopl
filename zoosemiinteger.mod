/*

let's see how easy moving to use semiinteger and semicontinuous decision variables with OPL.
Semiinteger means for example for a quantity of buses that it's either 0 or within a given range.
In our bus example, suppose we cannot rent less than 4 buses for any given size.

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
 (nbBus40==0) || (4<=nbBus40<=20);
 (nbBus30==0) || (4<=nbBus30<=20);
 
 
 40*nbBus40+nbBus30*30>=nbKids;
} 

/*

which gives

nbBus40 = 8;
nbBus30 = 0;

*/
