/*

Now a common question is : What should I do to try CPO (Constraint Programming)

The answer is quite easy.

Just add

    using CP;

Yes! 

*/



using CP;

int nbKids=300;
float costBus40=500;
float costBus30=400;
     
dvar int+ nbBus40;
dvar int+ nbBus30;
     
minimize
     costBus40*nbBus40  +nbBus30*costBus30;
     
subject to
{
  40*nbBus40+nbBus30*30>=nbKids;
}

