

/*

Monte Carlo simulation 
gives

 

    average cost = 3825
    

We know optimization helps and if we optimize in each scenarii we ll do better:
*/
 

    int nbKids=300;
     int nbMaxKidsAbsent=30;
     
     int nbSamples=20;
     range samples=1..nbSamples;
     
     int nbKidsLess[i in 1..nbSamples]=rand(nbMaxKidsAbsent); // uniform distribution

    int nbKidsOptions[i in samples]=nbKids-nbKidsLess[i];

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

    var averageCost=0;

    for(var i in thisOplModel.samples)
    {
    var nbKids=thisOplModel.nbKidsOptions[i];

    writeln("if we need to bring ",nbKids," kids  to the zoo");
        
    thisOplModel.ctKids.LB=nbKids;

    cplex.solve();
    thisOplModel.postProcess();
    writeln("And the cost is ",cplex.getObjValue());
    averageCost+=cplex.getObjValue();
    writeln();
    }

    averageCost=averageCost/thisOplModel.nbSamples;
    writeln("------------------------------");
    writeln("average cost = ",Math.ceil(averageCost));
    }

 
/*
gives

 

    average cost = 3675

So the school knows 3675 is the figure they could use instead of 3825

4% saving in the budget in that toy example.

But the conclusion is Monte Carlo optimization is pretty simple and helps do more with less.

 

See also stochastic optimization and robust optimization (slightly more complex) 

*/

