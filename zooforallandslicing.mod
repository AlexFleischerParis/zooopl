/*

I will share here a very simple example of forall which is OPL iterator / quantifier

And we ll see how we can simply use slicing : not take all elements but a subset. 

*/



    int nbKids=...;

    // a tuple is like a struct in C, a class in C++ or a record in Pascal
    tuple bus
    {
    key int nbSeats;
    float cost;
    string kind;
    }

    {string} kinds={"diesel","EV"};

    // This is a tuple set
    {bus} buses with kind in kinds=...;

    // asserts help make sure data is fine
    assert forall(b in buses) b.nbSeats>0;
    assert forall(b in buses) b.cost>0;

    int nbMaxDieselBus=...;

    // decision variable array
    dvar int nbBus[buses];

    // objective
    minimize
     sum(b in buses) b.cost*nbBus[b];
     
    // constraints
    subject to
    {
     sum(b in buses) b.nbSeats*nbBus[b]>=nbKids;
     
     // All numbers of buses should be positive
     
     forall(b in buses) nbBus[b]>=0;
     
     // max number of diesel vehicle
     
     // explicit slicing
     
     sum(b in buses:b.kind=="diesel") nbBus[b]<= nbMaxDieselBus;
     
     // implicit slicing
     
     sum(<b,c,"diesel"> in buses) nbBus[<b,c,"diesel">]<= nbMaxDieselBus;
    }

    tuple solution
    {
      key int nbSeats;
      int nbBus;
    }

    {solution} solutions={<b.nbSeats,nbBus[b]> | b in buses : nbBus[b]!=0};

    execute
    {
      writeln(solutions);
    }


/*

which gives

 {<30 5> <50 3>}
 
 */
