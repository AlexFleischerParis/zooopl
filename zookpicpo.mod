/*

let us continue https://www.linkedin.com/pulse/making-decision-optimization-simple-alex-fleischer/

*/

using CP;

int nbKids=300;
float costBus40=500;
float costBus30=400;
float costBus60=780;
 
dvar int+ nbBus40;
dvar int+ nbBus30;
dvar int+ nbBus60;

dexpr int nbBus=nbBus30+nbBus40;
dexpr float averageLoad=300/(nbBus30+nbBus40);

execute
{
  cp.addKPI(nbBus,"how many buses ?");
  cp.addKPI(averageLoad);
}
 
minimize
 costBus40*nbBus40  +nbBus30*costBus30+costBus60*nbBus60;
 
subject to
{

 40*nbBus40+nbBus30*30+60*nbBus60>=nbKids;
} 

main
{
  thisOplModel.generate();
  cp.solve();
  
  writeln("how many buses ?  ",cp.getKPIValue("how many buses ?"));
  writeln("averageLoad  ",cp.getKPIValue("averageLoad"));
}

/*

which gives

how many buses ?  6
averageLoad  50

*/
