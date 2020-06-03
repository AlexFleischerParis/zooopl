 //we saw how to warm start in CPLEX. Let s see how we can do the same with CPO in CPLEX:

 



 

    using CP;

    int nbKids=300;

    // a tuple is like a struct in C, a class in C++ or a record in Pascal
    tuple bus
    {
     key int nbSeats;
     float cost;
    }


    // This is a tuple set
    {bus} pricebuses=...;

    // asserts help make sure data is fine
    assert forall(b in pricebuses) b.nbSeats>0;assert forall(b in pricebuses) b.cost>0;


    // To compute the average cost per kid of each bus
    // you may use OPL modeling language

    float averageCost[b in pricebuses]=b.cost/b.nbSeats;

    // Let us try first with a naïve computation, use the cheapest bus

    float cheapestCostPerKid=min(b in pricebuses) averageCost[b];
    int cheapestBusSize=first({b.nbSeats | b in pricebuses : averageCost[b]==cheapestCostPerKid});
    int nbBusNeeded=ftoi(ceil(nbKids/cheapestBusSize));

    float cost0=item(pricebuses,<cheapestBusSize>).cost*nbBusNeeded;
    execute DISPLAY_Before_SOLVE
    {
      writeln("The naïve cost is ",cost0);
      writeln(nbBusNeeded," buses ",cheapestBusSize, " seats");
      writeln();
    }

    int naiveSolution[b in pricebuses]=
      (b.nbSeats==cheapestBusSize)?nbBusNeeded:0;


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

    // Warm start the naïve solution
    var sol=new IloOplCPSolution();
    for(var b in thisOplModel.pricebuses)
       sol.setValue(thisOplModel.nbBus[b],thisOplModel.naiveSolution[b]);
    cp.setStartingPoint(sol);

    cp.solve();
    thisOplModel.postProcess();
    }
/*
.dat

 

    pricebuses={<40,500>,<30,400>};

which gives

 

    The naïve cost is 4000
    8 buses 40 seats

    The minimum cost is 3800
    6 buses 40 seats
    2 buses 30 seats

and in the log we see

 

    ! ----------------------------------------------------------------------------
     ! Minimization problem - 2 variables, 1 constraint
     ! Using starting point solution
     
     */

