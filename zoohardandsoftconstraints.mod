int nbKids=300;
float costBus40=500;
float costBus30=400;
 
dvar int+ nbBus40;
dvar int+ nbBus30;
 
minimize
 costBus40*nbBus40  +nbBus30*costBus30;
 
subject to
{
 nbBus40>=0;
 nbBus30>=0; 
  
 // using a label for the constraint makes the constraint a soft constraint 
 ctAllKidsNeedToGo:
     40*nbBus40+nbBus30*30>=nbKids;
 
 // commenting the label of the constraints turn the constraint into a hard constraint
 //ctMaxTotalBuses:
     nbBus30+nbBus40<=7;
} 

main
{
thisOplModel.generate();
if (!cplex.solve())
{
writeln(thisOplModel.printRelaxation());
writeln(thisOplModel.printConflict());
}
} 

/*

which gives

ctAllKidsNeedToGo 
    relax [300,Infinity] to [280,Infinity] value is 280

ctAllKidsNeedToGo at 
  is in conflit.
  
  */
