 /*
 
 But now suppose we do not need only the optimal solution but a few alternatives to share.

Solution pools!

Let me share a tiny example:

*/

    int nbKids=300;
    float costBus40=500;
    float costBus30=400;
     
    dvar int+ nbBus40;
    dvar int+ nbBus30;
     
    //minimize
     //costBus40*nbBus40  +nbBus30*costBus30;
     
    subject to
    {
     40*nbBus40+nbBus30*30>=nbKids;
    }

    execute
    {
    writeln("nbBus40 = ",nbBus40," and nbBus30 = ",nbBus30," and the cost is ",costBus40*nbBus40  +nbBus30*costBus30);
    }

     main {
    cplex.solnpoolintensity=4;

        thisOplModel.generate();
        cplex.solve();
        if (cplex.populate()) {
          var nsolns = cplex.solnPoolNsolns;
          
          
          writeln("Number of solutions found = ",nsolns);
          writeln();
          for (var s=0; s<nsolns; s++) {
            thisOplModel.setPoolSolution(s);
            thisOplModel.postProcess();
          }
        }
    }

/* 

which gives

 

    Number of solutions found = 3

    nbBus40 = 6 and nbBus30 = 2 and the cost is 3800
    nbBus40 = 7 and nbBus30 = 1 and the cost is 3900
    nbBus40 = 8 and nbBus30 = 0 and the cost is 4000
    
    */

