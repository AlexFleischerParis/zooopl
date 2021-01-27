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

    execute
    {
    writeln("nbBus40 = ",nbBus40);
    writeln("nbBus30 = ",nbBus30);
    }

    main
    {
    thisOplModel.generate();

    cplex.solve();
    thisOplModel.postProcess();
    
    writeln("coef for nbBus40 : ",cplex.getCoef(thisOplModel.ctKids,thisOplModel.nbBus40));
    writeln("coef for nbBus30 : ",cplex.getCoef(thisOplModel.ctKids,thisOplModel.nbBus30));
    
    // And now let us allow 5 more kids per bus
    writeln("And now let us allow 5 more kids per bus");
    cplex.setCoef(thisOplModel.ctKids,thisOplModel.nbBus40,40+5);
    cplex.setCoef(thisOplModel.ctKids,thisOplModel.nbBus30,30+5);
    
    cplex.solve();
    thisOplModel.postProcess();
    
    
  }    
  
  /*
  
  which gives
  
  nbBus40 = 6
nbBus30 = 2
coef for nbBus40 : 40
coef for nbBus30 : 30
And now let us allow 5 more kids per bus
nbBus40 = 6
nbBus30 = 1

*/
