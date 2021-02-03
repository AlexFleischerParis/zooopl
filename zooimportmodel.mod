main
{
  cplex.importModel("zoo.lp");
  cplex.solve();
  writeln("obj = ",cplex.getObjValue());
  
}

/*

which gives

obj = 3800

*/