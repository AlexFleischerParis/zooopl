 /*
 
 Again let me say that in OPL you have 2 different languages:

    OPL (The modeling language)
    OPL scripting (Javascript) that can be used in preprocessing, postprocessing, flow control or in the data file

 

It's possible to mix those 2 languages and let me share a  small example:

*/

    int nbKids=...;

    // a tuple is like a struct in C, a class in C++ or a record in Pascal
    tuple bus
    {
    key int nbSeats;
    float cost;
    }


    // This is a tuple set
    {bus} pricebuses=...;

    // asserts help make sure data is fine
    assert forall(b in pricebuses) b.nbSeats>0;
    assert forall(b in pricebuses) b.cost>0;


    // To compute the average cost per kid of each bus
    // you may use OPL modeling language

    float averageCost[b in pricebuses]=b.cost/b.nbSeats;

    // or OPL scripting

    float averageCost2[pricebuses];

    execute compute_average_price
    {
    for(var b in pricebuses) averageCost2[b]=b.cost/b.nbSeats;
    }

    assert forall(b in pricebuses) averageCost[b]==averageCost2[b];

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

/* 

.dat
    nbKids=300;
    pricebuses={<40,500>,<30,400>};

which gives

 

    The naïve cost is 4000
    8 buses 40 seats

    // solution (optimal) with objective 3800
    The minimum cost is 3800
    6 buses 40 seats
    2 buses 30 seats

*/