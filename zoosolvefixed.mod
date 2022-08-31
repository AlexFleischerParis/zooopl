/*

Shadow price or dual price is the improvement in the contribution or costs by having 
one additional unit of a  resource which is causing a bottleneck.

In linear programming, reduced cost, or opportunity cost, is the amount by which 
an objective function coefficient would have to improve (so increase 
for maximization problem, decrease for minimization problem) before it
 would be possible for a corresponding variable to assume a positive value in 
 the optimal solution. (Wikipedia)
 
 */ 
 
 
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
    
    
Initial Model
7.5 buses 40 seats and 0 buses 30 seats
OBJECTIVE: 3750
solveFixed
OBJECTIVE: 3750
dual of the kids constraint = 12.5
reduced cost of nbBus30 = 25
