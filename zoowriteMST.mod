

    include "zoo.mod";

    main {
      var filename = "c:/temp/mipstart.mst";

      // First solve from scratch and export optimal solution as MIP start.  
      thisOplModel.generate();
      cplex.solve();
      writeln("Objective: " + cplex.getObjValue());
     
      cplex.writeMIPStarts(filename, 0, 1);
     
     
     
    }

/*
will generate mipstart.mst

    <?xml version = "1.0" encoding="UTF-8" standalone="yes"?>
    <CPLEXSolutions version="1.2">
     <CPLEXSolution version="1.2">
      <header
        problemName="zoowritemipstart"
        solutionName="m1"
        solutionIndex="0"
        MIPStartEffortLevel="0"
        writeLevel="2"/>
      <variables>
       <variable name="nbBus40" index="0" value="6"/>
       <variable name="nbBus30" index="1" value="2"/>
      </variables>
     </CPLEXSolution>
    </CPLEXSolutions>
*/
