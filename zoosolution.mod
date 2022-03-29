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
writeln("objective = ",cplex.getObjValue());
writeln("Solution status = ",cplex.status )
writeln("number of constraints = ",cplex.getNrows())
writeln("abs gap = ",Math.abs(cplex.getObjValue()-cplex.getBestObjValue()));
}

/*

gives

objective = 3800
Solution status = 1
number of constraints = 1
abs gap = 0

*/
