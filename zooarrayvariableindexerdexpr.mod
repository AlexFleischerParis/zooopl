/*

Variable indexer size:

we'd like to be able to write

dvar int+ nbBus[s in scenarii][sizes[s]];

but we get an error "Variable indexer size not allowed"

So what can we do ?

We saw 2 options:

1) Rely on a tuple set that contains all options 
instead of a multi dimension array
2) For the variable dimension use the union of all options

1) Is good but the drawback is that relying on a tuple set makes the 
constraint harder to read for a human being

2) Is good but a bit suboptimal since we use options that are useless and 
consume memory for no gain.

We can mix 1) and 2) with decision expressions

*/

int nbKids=300;

tuple busscenario
{
  key int nbSeats;
  key int scenario;
  float cost;
}

{busscenario} busscenarii={<40,1,500>,<30,1,400>,<30,2,410>,<35,2,440>,<40,2,520>}; 

{int} scenarii={i.scenario | i in busscenarii};

{int} sizeBusesPerScenario[scen in scenarii]={i.nbSeats | i in busscenarii : i.scenario==scen};

{int} busSizes=union(scen in scenarii) sizeBusesPerScenario[scen];

// decision variable array with variable size
dvar int+ nbBus2[busscenarii];

// decision expression array with variable size
dexpr int nbBus[sc in scenarii][b in busSizes]=nbBus2[<b,sc>];

dexpr float cost[sc in scenarii][b in busSizes]=item(busscenarii,<b,sc>).cost;

// objective
minimize
     1/card(scenarii)*sum(sc in scenarii,b in sizeBusesPerScenario[sc]) 
     cost[sc][b]*nbBus[sc][b];
     
// constraints
subject to
{
   forall(sc in scenarii) sum(b in sizeBusesPerScenario[sc]) b*nbBus[sc][b]>=nbKids;
}

execute
{
  for(sc in scenarii)
  {
    writeln("scenario ",sc);
    for(var b in sizeBusesPerScenario[sc]) writeln(nbBus[sc][b]," buses ",b," seats" );
    writeln();
  }
}

/*

which gives

// solution (optimal) with objective 3820
scenario 1
6 buses 40 seats
2 buses 30 seats

scenario 2
0 buses 30 seats
4 buses 35 seats
4 buses 40 seats

*/
