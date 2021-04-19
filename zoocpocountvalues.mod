 /*
 
 The challenge is again to model 
 
 https://www.linkedin.com/pulse/what-optimization-how-can-help-you-do-more-less-zoo-buses-fleischer/

let us see how we can count values

*/

using CP;

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

range quantity = 0..10;

// decision variable array
dvar int+ nbBus[buses] in quantity;

// objective
minimize
     sum(b in buses) b.cost*nbBus[b];
     
// constraints
subject to
{
   sum(b in buses) b.nbSeats*nbBus[b]>=nbKids;
   
   // Quantities should have less than 1 value
   
   (sum(q in quantity)
    //(1<=sum(b in buses) (q==nbBus[b])) <=1;
    (count(nbBus,q)>=1))<=1;
}

/*

which gives

nbBus = [3 3 3 3];

         
         */

