 //Now let's see how easy it is to relax integrity constraints and 
 //turn a MIP into LP, solve and get dual value (shadow price)

    int nbKids=300;
    float costBus40=500;
    float costBus30=400;
     
    dvar int+ nbBus40;
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
        writeln("Integer Model");   
        writeln("OBJECTIVE: ",cplex.getObjValue());   
        
      }

      // relax integrity constraint
      thisOplModel.convertAllIntVars();
     
      if (cplex.solve()) {
        writeln("Relaxed Model");   
        writeln("OBJECTIVE: ",cplex.getObjValue());  
        
        writeln("dual of the kids constraint = ",thisOplModel.ctKids.dual);
        writeln("reduced costs for nbbus40 : ",thisOplModel.nbBus40.reducedCost);
        writeln("reduced costs for nbbus30 : ",thisOplModel.nbBus30.reducedCost);
      }
       
     
    }

/* 

gives

 

    Integer Model
    OBJECTIVE: 3800
    Relaxed Model
    OBJECTIVE: 3750
    dual of the kids constraint = 12.5
    reduced costs for nbbus40 : 0
    reduced costs for nbbus30 : 25

 

And we can confirm that if we use only 40 seats buses the marginal cost of a seat within a 40 seats bus is costbus40/40=12.5
And that if we remove 25 to the price for 30 seats buses then they are as cheap as 40 seats buses.

*/
