{int} sizes={40,30};

int nbKids=200;
float costBus[sizes]=[500,400];

 
dvar int+ nbBus[sizes];

 
minimize
 sum(s in sizes) nbBus[s]*costBus[s];
subject to
{
 sum(s in sizes) nbBus[s]*s>=nbKids;
 
// all : all quantities should be less than 5
forall(s in sizes) nbBus[s]<=5;

// any : one of the quantities should be 1
1<=sum(s in sizes) (nbBus[s]==1);
} 

assert forall(s in sizes) nbBus[s]<=5;
assert or(s in sizes)  (nbBus[s]==1);

/*

which gives

nbBus = [2 4];
         
         */
