 /*
 
 The challenge is again to model 
 
 https://www.linkedin.com/pulse/what-optimization-how-can-help-you-do-more-less-zoo-buses-fleischer/

let us see how we can count true constraints

*/

int nbKids=300;

// a tuple is like a struct in C, a class in C++ or a record in Pascal
tuple bus
{
  key int nbSeats;
  float cost;
}

// This is a tuple set
{bus} buses={<40,500>,
    <30,400>,
    <35,450>,
    <20,300>};

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
   
   // Number of sizes where we have 1 or 2 buses should be at least 3
   
   sum(b in buses) (1<=nbBus[b]<=2) >=3;
}

/*

which gives

nbBus = [4 1 2 2];

         
         */