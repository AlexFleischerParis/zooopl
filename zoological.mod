/*

    40*nbBus40+nbBus30*30>=nbKids;

is a linear constraint. But sometimes we need more than linear constraints.

Suppose now, we have a contract change and we need to pay 500 more if we use 2 kind of buses instead of 1.

Then we could write

*/

    int nbKids=300;
    float costBus40=460;
    float costBus30=360;

    // Contract change : +500 if we use 2 kind of buses
     
    dvar int+ nbBus40;
    dvar int+ nbBus30;

    dvar int+ nbKindOfBuses;
     
    minimize
     costBus40*nbBus40  +nbBus30*costBus30+(nbKindOfBuses-1)*(500);
     
    subject to
    {
     40*nbBus40+nbBus30*30>=nbKids;
     
     nbKindOfBuses==(nbBus40!=0)+(nbBus30!=0);
    }


    execute DISPLAY_After_SOLVE
    {
    writeln("The minimum cost is ",cplex.getObjValue());
    writeln("We will use ",nbBus40," 40 seats buses and ",nbBus30," 30 seats buses ");
    }

/*

which gives

The minimum cost is 3600
We will use 0 40 seats buses and 10 30 seats buses
and

 

    nbKindOfBuses==(nbBus40!=0)+(nbBus30!=0);

is allowed and we call this a logical constraint.

regards

NB:

Since we use logical constraints for a zoo, we understand a bit better why we say zoological!

and many other very simple examples at https://www.linkedin.com/pulse/making-decision-optimization-simple-alex-fleischer/

 */ 
