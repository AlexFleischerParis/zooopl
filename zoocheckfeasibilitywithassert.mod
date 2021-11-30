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
    
    // the option we choose
    int option=3;
      
    // decision variable array
    //dvar int+ nbBus[pricebuses];
    // changed into data array if we only check feaibility
    int nbBus[p in pricebuses]=testSolution[option][p];

    // objective
    float objective=
      sum(b in pricebuses) b.cost*nbBus[b];
         
    // constraints are changed into asserts
    //subject to
    
      assert ctKids:sum(b in pricebuses) b.nbSeats*nbBus[b]>=nbKids;
    

    
    execute DISPLAY
    {
     writeln("The cost is ",objective);
     for(var b in pricebuses) writeln(nbBus[b]," buses ",b.nbSeats, " seats");

    }

/*

For option = 3 we get

The cost is 4100
5 buses 40 seats
4 buses 30 seats

and for 1 and 2 we get assert violation

*/
    
