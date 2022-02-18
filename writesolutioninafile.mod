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
  var o=new IloOplOutputFile("c:\\temp\\zoosol.txt");
  o.writeln("nbBus40=",nbBus40,";");
  o.writeln("nbBus30=",nbBus30,";");
  o.close();
}

main
{
  thisOplModel.generate();
  cplex.solve();
  cplex.writeMIPStarts("c:\\temp\\zoomipstartsol"); 
  thisOplModel.postProcess();
}

/*

In zoosol.txt we get

nbBus40=6;
nbBus30=2;

*/
