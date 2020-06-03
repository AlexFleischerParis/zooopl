 /*
 
 The challenge is again to model 
 
 https://www.linkedin.com/pulse/what-optimization-how-can-help-you-do-more-less-zoo-buses-fleischer/

Let us replace arrays by tuple sets so on top of cost we could add other properties easily.

*/

int nbKids=...;

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

