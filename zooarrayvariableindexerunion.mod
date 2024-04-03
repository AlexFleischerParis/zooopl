/*

Variable indexer size:

we'd like to be able to write

dvar int+ nbBus[s in scenarii][sizes[s]];

but we get an error "Variable indexer size not allowed"

So what can we do ?

Here we'll see one of the options:

Rely on a tuple set that contains all options 
instead of a multi dimension array

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
{int} unionOfAllBusSizes={s.nbSeats| s in busscenarii};

// decision variable array with variable size
dvar int+ nbBus[sc in scenarii][b in unionOfAllBusSizes];

// objective
minimize
     1/card(scenarii)*sum(sc in scenarii) sum(bsc in busscenarii:bsc.scenario==sc) 
     bsc.cost*nbBus[sc][bsc.nbSeats];
     
// constraints
subject to
{
   forall(sc in scenarii) sum(bsc in busscenarii:bsc.scenario==sc) 
     bsc.nbSeats*nbBus[sc][bsc.nbSeats]>=nbKids;
}

execute
{
  for(sc in scenarii)
  {
    writeln("scenario ",sc);
    for(var b in busscenarii) if (b.scenario==sc) writeln(nbBus[sc][b.nbSeats]," buses ",b.nbSeats," seats" );
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
