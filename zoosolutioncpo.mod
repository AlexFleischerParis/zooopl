using CP;

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
} 

execute
{
writeln("objective = ",cp.getObjValue());
writeln("Solution status = ",cp.info.SearchStatus );
writeln("number of constraints = ",cp.info.NumberOfConstraints)
writeln("gap = ",cp.info.Gap);
}

/*

gives

objective = 3800
Solution status = 45
number of constraints = 1
gap = 0

*/

