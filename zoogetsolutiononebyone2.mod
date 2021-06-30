execute
{
  thisOplModel.settings.run_processFeasible=1;
}

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
  writeln("nbBus40 = ",nbBus40);
  writeln("nbBus30 = ",nbBus30);
  writeln("best bound = ",cplex.getBestObjValue());
  writeln("objective = ",cplex.getObjValue());
  writeln("status =",cplex.status);
}

/*

// feasible solution with objective 4000
nbBus40 = 8
nbBus30 = 0
best bound = -Infinity
objective = 4000
status =0
// feasible solution with objective 3900
nbBus40 = 7
nbBus30 = 1
best bound = -Infinity
objective = 3900
status =0
// solution (optimal) with objective 3800
nbBus40 = 6
nbBus30 = 2
best bound = 3800
objective = 3800
status =1

*/
