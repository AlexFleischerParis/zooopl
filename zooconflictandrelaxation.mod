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

/*

will display conflict and relaxation in the IDE but you can get that in script with

main
{
thisOplModel.generate();
if (!cplex.solve())
{
writeln(thisOplModel.printRelaxation());
writeln(thisOplModel.printConflict());
}
} 

which gives



    ctMaxTotalBuses
        relax [-Infinity,7] to [-Infinity,8] value is -Infinity

    ctAllKidsNeedToGo
      is in conflict
    ctMaxTotalBuses
      is in conflict


*/
