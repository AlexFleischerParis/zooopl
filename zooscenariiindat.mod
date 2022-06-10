tuple scenario
{
  float costBus40;
  float costBus30;
  int nbKids;
}

{scenario} scenarii=...;

main
{
  var source = new IloOplModelSource("zoodat.mod");
  var cplex = new IloCplex();
  var def = new IloOplModelDefinition(source);
  
  for(var s in thisOplModel.scenarii)
  {
  	var opl = new IloOplModel(def,cplex);
    var data2= new IloOplDataElements();
    data2.costBus40=s.costBus40;
    data2.costBus30=s.costBus30;
    data2.nbKids=s.nbKids;
    
    writeln("if we need to bring ",s.nbKids," kids  to the zoo");
    writeln("with costs ",s.costBus40," and ",s.costBus30)
    
    opl.addDataSource(data2);
    opl.generate();
    cplex.solve();
    opl.postProcess();
    writeln();
}  
  
  
}

/*

if we need to bring 300 kids  to the zoo
with costs 500 and 400
The minimum cost is 3800
We will use 6 40 seats buses and 2 30 seats buses 

if we need to bring 320 kids  to the zoo
with costs 550 and 450
The minimum cost is 4400
We will use 8 40 seats buses and 0 30 seats buses 

if we need to bring 330 kids  to the zoo
with costs 600 and 440
The minimum cost is 4840
We will use 0 40 seats buses and 11 30 seats buses 

*/