

    include "zoo.mod";

    main {
     var filename = "c:/temp/mipstart.mst";
      thisOplModel.generate();
      cplex.readMIPStarts(filename);
      cplex.solve();
      writeln("Objective: " + cplex.getObjValue());
     
    }

/*
will use that mst file and warm start from there

 

And in the log you will notice

    MIP start 'm1' defined initial solution with objective 3800.0000.
    
    */

