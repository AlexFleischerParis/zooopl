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
 ctAllKidsNeedToGo:
     40*nbBus40+nbBus30*30>=nbKids;
 
 ctMaxTotalBuses:
     nbBus30+nbBus40<=7;
} 

main
{
thisOplModel.generate();
if (!cp.solve())
{
writeln(thisOplModel.printConflict());
}
} 

/*

which gives

ctAllKidsNeedToGo a
  is in conflict.
ctMaxTotalBuses
  is in conflict.
  
  */
