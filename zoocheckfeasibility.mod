    int nbKids=300;

    // a tuple is like a struct in C, a class in C++ or a record in Pascal
    tuple bus
    {
     key int nbSeats;
     float cost;
    }


    // This is a tuple set
    {bus} pricebuses={<40,500>,<30,400>};

    // asserts help make sure data is fine
    assert forall(b in pricebuses) b.nbSeats>0;assert forall(b in pricebuses) b.cost>0;

    // solutions we want to test
    range options=1..3;
    int testSolution[options][pricebuses]=[[5,2],[5,3],[5,4]];
      
    // decision variable array
    dvar int+ nbBus[pricebuses];

    // objective
    minimize
      sum(b in pricebuses) b.cost*nbBus[b];
         
    // constraints
    subject to
    {
      sum(b in pricebuses) b.nbSeats*nbBus[b]>=nbKids;
    }

    float cost=sum(b in pricebuses) b.cost*nbBus[b];
    execute DISPLAY_After_SOLVE
    {
     writeln("The minimum cost is ",cost);
     for(var b in pricebuses) writeln(nbBus[b]," buses ",b.nbSeats, " seats");

    }


    main
    {
    thisOplModel.generate();
    // Test feasibility through fixed start
    
    for(var o in thisOplModel.options)
    {
       for(var b in thisOplModel.pricebuses)
       {
          thisOplModel.nbBus[b].UB=thisOplModel.testSolution[o][b];
          thisOplModel.nbBus[b].LB=thisOplModel.testSolution[o][b];
       }
       if (cplex.solve())
       {
         write(thisOplModel.testSolution[o]," is feasible");
         writeln(" and the cost is ",cplex.getObjValue());
       }
       else writeln(thisOplModel.testSolution[o]," is not feasible");
    }
    }    

/*

which gives

[5 2] is not feasible
[5 3] is not feasible
[5 4] is feasible and the cost is 4100

*/
