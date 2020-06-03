    {string} datFiles={"zoodat.dat","zoodat2.dat"};
    
    main
    {
      var source = new IloOplModelSource("zoodat.mod");
      var cplex = new IloCplex();
      var def = new IloOplModelDefinition(source);
     
      for(datFile in thisOplModel.datFiles)
      {
         writeln("with ",datFile);
         var opl1 = new IloOplModel(def,cplex);
         var data1=new IloOplDataSource(datFile);
          opl1.addDataSource(data1);
        
          opl1.generate();
          cplex.solve();
          opl1.postProcess();
          writeln();
   

        }

 }
 
 /*
 
 which gives
 
 with zoodat.dat
The minimum cost is 380
We will use 6 40 seats buses and 2 30 seats buses 

with zoodat2.dat
The minimum cost is 500
We will use 10 40 seats buses and 0 30 seats buses 

*/   