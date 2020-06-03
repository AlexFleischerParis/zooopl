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
    cplex.addMIPStart(thisOplModel.nbBus,thisOplModel.naiveSolution);
    cplex.solve();
    thisOplModel.postProcess();
    }

 
/*
.dat

    pricebuses={<40,500>,<30,400>};

and then we get

 

    The naïve cost is 4000
    8 buses 40 seats

    The minimum cost is 3800
    6 buses 40 seats
    2 buses 30 seats

and in the cplex log we see

    1 of 1 MIP starts provided solutions.
    MIP start 'm1' defined initial solution with objective 4000.0000.

The warmstart is in the line

    // Warm start the naïve solution
    cplex.addMIPStart(thisOplModel.nbBus,thisOplModel.naiveSolution);

*/

