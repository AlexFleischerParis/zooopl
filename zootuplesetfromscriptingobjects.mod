/*

In this example we will use OPL scripting objects that we
will turn into OPL tuple sets

*/

int nbKids=300;

tuple bus
{
  key int nbSeats;
  float cost;
}

{bus} buses={};

execute
{
  var busArray=new Array(2);
  
  function processBus()
  {
    buses.add(this.nbSeats,this.cost);
  }
  
  // An object bus has 2 fields : nbSeats and cost plus a function process
  
  busArray[1]=new Object();
  busArray[1].nbSeats=40;
  busArray[1].cost=500;
  
  busArray[2]=new Object();
  busArray[2].nbSeats=30;
  busArray[2].cost=400;
  
  for(var i=1;i<=2;i++) busArray[i].process=processBus;
  
  // This line will add the buses that are in scripting objects into OPL tuple set
  for(var i=1;i<=2;i++) busArray[i].process();
}

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

execute
{
  writeln(buses);
  writeln(nbBus);
}

/*

which gives

{<40 500> <30 400>}
[6 2]

*/


