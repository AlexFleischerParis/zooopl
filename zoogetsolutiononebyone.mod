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

main
{
  thisOplModel.generate();
  cplex.intsollim=1;
  while (1==1)
  {
    cplex.solve();
    thisOplModel.postProcess();
    if (cplex.status==1) break;
  }
}

/*

gives

nbBus40 = 8
nbBus30 = 0
best bound = 0
objective = 4000
status =104
nbBus40 = 7
nbBus30 = 1
best bound = 3750
objective = 3900
status =104
nbBus40 = 6
nbBus30 = 2
best bound = 3800
objective = 3800
status =1

*/
