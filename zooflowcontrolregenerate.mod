/*
We saw in zooflowcontrolincremental how to do some incremental changes.

 But quite often those incremental changes are not enough for some changes and 
 
 then we need to generate again the model. (regenerate)

Let's see how  we can simply do that with the same tiny example. 

*/


    main
    {
      var source = new IloOplModelSource("sub.mod");
      var cplex = new IloCplex();
      var def = new IloOplModelDefinition(source);
     
      var opl1 = new IloOplModel(def,cplex);
      var data1=new IloOplDataElements();
      data1.costBus40=500;
      data1.costBus30=400;
      data1.maxBus40=100;
      data1.maxBus30=100;
      data1.nbKids=300;
     
     
      opl1.addDataSource(data1);
        
      opl1.generate();
      cplex.solve();
      opl1.postProcess();
     
    //    //now 350 kids instead of 300
      writeln("now 350 kids instead of 300");
     
     
      data1.nbKids=350;
      var opl2 = new IloOplModel(def,cplex);
      opl2.addDataSource(data1);
        
      opl2.generate();
      cplex.solve();
      opl2.postProcess();

    // no more than 4 buses 40 seats
      writeln("no more than 4 buses 40 seats");
      data1.maxBus40=4;
     
      var opl3 = new IloOplModel(def,cplex);
      opl3.addDataSource(data1);
        
      opl3.generate();
      cplex.solve();
      opl3.postProcess();
     
    // change the objective so that cost for 40 seats is 450
    // and remove the limit on the number of buses 40 seats

      writeln("change the objective so that cost for 40 seats is 450");
      writeln("and remove the limit on the number of buses 40 seats");    
     
      data1.maxBus40=100;
      data1.costBus40=450;
     
      var opl4 = new IloOplModel(def,cplex);
      opl4.addDataSource(data1);
        
      opl4.generate();
      cplex.solve();
      opl4.postProcess();


        }

     
/*
 

which gives

 

    nbBus40 = 6
    nbBus30 = 2
    now 350 kids instead of 300
    nbBus40 = 8
    nbBus30 = 1
    no more than 4 buses 40 seats
    nbBus40 = 2
    nbBus30 = 9
    change the objective so that cost for 40 seats is 450
    and remove the limit on the number of buses 40 seats
    nbBus40 = 8
    nbBus30 = 1
    
    */
