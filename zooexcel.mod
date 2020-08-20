/*

Now let s suppose we do not want to read and write data from a text file as we did previously but from a spreadsheet

In order to do that we may use SheetRead and SheetWrite:

*/



    tuple param
    {
    int nbKids;
    }

    {param} params=...;

    assert card(params)==1;

    int nbKids=first(params).nbKids;

    // a tuple is like a struct in C, a class in C++ or a record in Pascal
    tuple bus
    {
    key int nbSeats;
    float cost;
    }

    // This is a tuple set
    {bus} buses=...;

    // asserts help make sure data is fine
    assert forall(b in buses) b.nbSeats>0;
    assert forall(b in buses) b.cost>0;

    // decision variable array
    dvar int+ nbBus[buses];

    // objective
    minimize
     sum(b in buses) b.cost*nbBus[b];
     
    // constraints
    subject to
    {
     sum(b in buses) b.nbSeats*nbBus[b]>=nbKids;
    }

    tuple result
    {
       key int nbSeats;
       int nbBuses;
    }

    {result} results={<b.nbSeats,nbBus[b]> | b in buses};

/*

and in the .dat we have

SheetConnection s("zoo.xlsx");

params from SheetRead(s,"params!A2");
buses from SheetRead(s,"buses!A2:B3");
results to SheetWrite(s,"buses!E2:F3");

or if we prefer to rely on named range

SheetConnection s("zoonamedrange.xlsx");

params from SheetRead(s,"nbkids");
buses from SheetRead(s,"buses");
results to SheetWrite(s,"result");

*/