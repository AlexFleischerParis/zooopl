/*

let us continue https://www.linkedin.com/pulse/making-decision-optimization-simple-alex-fleischer/

Now suppose you need to have some more abstraction and you want to be able to have the model and the values not together.

You write a .mod and a .dat 

= ...; means defined somewhere else

*/

int nbKids=...;
float costBus40=...;
float costBus30=...;
 
dvar int+ nbBus40;
dvar int+ nbBus30;
 
minimize
 costBus40*nbBus40  +nbBus30*costBus30;
 
subject to
{
 40*nbBus40+nbBus30*30>=nbKids;
} 

execute DISPLAY_After_SOLVE
    {
    writeln("The minimum cost is ",cplex.getObjValue());
    writeln("We will use ",nbBus40," 40 seats buses and ",nbBus30," 30 seats buses ");
    }
