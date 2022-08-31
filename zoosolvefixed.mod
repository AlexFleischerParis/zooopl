    int nbKids=300;
    float costBus40=500;
    float costBus30=400;
     
    dvar float+ nbBus40;
    dvar int+ nbBus30;
     
    minimize
     costBus40*nbBus40  +nbBus30*costBus30;
     
    subject to
    {
     ctKids:40*nbBus40+nbBus30*30>=nbKids;
    }
    main {
      var status = 0;
      thisOplModel.generate();
      if (cplex.solve()) {
        writeln("Initial Model");   
        write(thisOplModel.nbBus40, " buses 40 seats and ");
        writeln(thisOplModel.nbBus30, " buses 30 seats");
        writeln("OBJECTIVE: ",cplex.getObjValue());   
        
      }
      
      /*
      
      var solbus40=thisOplModel.nbBus40.solutionValue;
      
      // relax integrity constraint
      thisOplModel.convertAllIntVars();
      thisOplModel.nbBus40.UB=solbus40;
      thisOplModel.nbBus40.LB=solbus40;
      
      
      if (cplex.solve()) {
        writeln("Relaxed Model");   
        writeln("OBJECTIVE: ",cplex.getObjValue());  
        
        writeln("dual of the kids constraint = ",thisOplModel.ctKids.dual);
      }
      
      */
      
      //which can be simply rewritten into
      
      writeln("solveFixed");
      cplex.solveFixed();
      writeln("OBJECTIVE: ",cplex.getObjValue());  
      writeln("dual of the kids constraint = ",thisOplModel.ctKids.dual);     
      writeln("reduced cost of nbBus30 = ",thisOplModel.nbBus30.reducedCost);
     
    }
    
    
/*

Initial Model
OBJECTIVE: 3766.666666667
solveFixed
OBJECTIVE: 3766.666666667
dual of the kids constraint = 13.333333333

*/
