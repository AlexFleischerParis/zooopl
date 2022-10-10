   int nbKids=300;
    float costBus40=500;
    float costBus30=400;
     
    dvar int+ nbBus40;
    dvar float+ nbBus30;
    
    dvar int nbBus30i;
     
    minimize
     costBus40*nbBus40  +nbBus30*costBus30;
     
    subject to
    {
     ctKids:40*nbBus40+nbBus30*30>=nbKids;
     
     ctIntegerNbBus30:nbBus30i-nbBus30==0;

    }
    
    execute
    {
      writeln("nbBus40 = ",nbBus40);
      writeln("nbBus30 = ",nbBus30);
    }

    main {
      var status = 0;
      thisOplModel.generate();
      if (cplex.solve()) {
        writeln("Integer Model");   
        writeln("OBJECTIVE: ",cplex.getObjValue());   
        thisOplModel.postProcess();
      }

      // relax integrity constraint on nbbus30
      cplex.setLb(thisOplModel.ctIntegerNbBus30,-Infinity);
      cplex.setUb(thisOplModel.ctIntegerNbBus30,Infinity);
      
      
     
      if (cplex.solve()) {
        writeln("Relaxed Model");   
        writeln("OBJECTIVE: ",cplex.getObjValue());  
        
        thisOplModel.postProcess();
      }
      
      // set the integrity constraint back
      
      cplex.setLb(thisOplModel.ctIntegerNbBus30,0);
      cplex.setUb(thisOplModel.ctIntegerNbBus30,0);
      
      if (cplex.solve()) {
        writeln("Integer Model");   
        writeln("OBJECTIVE: ",cplex.getObjValue());   
        thisOplModel.postProcess();
      }
       
     
    }
    
    /*
    
    Integer Model
OBJECTIVE: 3800
nbBus40 = 6
nbBus30 = 2
Relaxed Model
OBJECTIVE: 3766.666666667
nbBus40 = 7
nbBus30 = 0.666666667
Integer Model
OBJECTIVE: 3800
nbBus40 = 6
nbBus30 = 2

*/
