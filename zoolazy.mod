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
 lazyCt:0<=0; // nbBus40<=5;
} 

execute
{
writeln("nbBus40 = ",nbBus40);
writeln("nbBus30 = ",nbBus30);
}

main
{
  thisOplModel.generate();
  cplex.solve();
  
  nbBus40=thisOplModel.nbBus40.solutionValue;
  if (nbBus40>5)
  {
    thisOplModel.lazyCt.setCoef(thisOplModel.nbBus40,1);
    thisOplModel.lazyCt.UB=5;
    cplex.solve();
  }
  
  thisOplModel.postProcess();
  
  
}

/*

which gives

nbBus40 = 3
nbBus30 = 6

*/

