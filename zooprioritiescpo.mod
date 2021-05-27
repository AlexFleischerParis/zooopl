/*

Here let's see how to tell CPLEX CPOptimizer to branch fisrt on nbBus40 and then on nbBus30

*/

using CP;

int nbKids=300;
float costBus40=500;
float costBus30=400;
     
dvar int+ nbBus40;
dvar int+ nbBus30;

execute {
   var f = cp.factory;
   cp.setSearchPhases(f.searchPhase(nbBus40));
}

     
minimize
     costBus40*nbBus40  +nbBus30*costBus30;
     
subject to
{
  40*nbBus40+nbBus30*30>=nbKids;
}

