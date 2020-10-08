     using CP;

     int nbKids=300;

    // a tuple is like a struct in C, a class in C++ or a record in Pascal
    tuple bus
    {
     key int nbSeats;
     float cost;
    }


    // This is a tuple set
    {bus} pricebuses={<40,500>,<30,400>};;

    // asserts help make sure data is fine
    assert forall(b in pricebuses) b.nbSeats>0;assert forall(b in pricebuses) b.cost>0;
    
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
    // Fixed start nbBus40 should be 5
    thisOplModel.nbBus[thisOplModel.pricebuses.find(40)].LB=5;
    thisOplModel.nbBus[thisOplModel.pricebuses.find(40)].UB=5;
    cp.solve();
    thisOplModel.postProcess();
    }

 
/*


and then we get

The minimum cost is 4100
5 buses 40 seats
4 buses 30 seats

Fixed start unlike warmstart does not challenge the additional constraints,
which can help reduce the search space size.
    

*/


