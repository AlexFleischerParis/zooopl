/*

 In Constraint Programming decision variables have to be integer but sometimes we need more than this.

Let's see how we can handle through decision expressions.

Suppose in the bus example we want to book not only whole buses but also percentage of buses.

Then we can write

*/

    using CP;

    int nbKids=310;
    float costBus40=500;
    float costBus30=400;
    int scale=100;

     
    dvar int+ scalenbBus40;
    dvar int+ scalenbBus30;

    dexpr float nbBus40=scalenbBus40/scale;
    dexpr float nbBus30=scalenbBus30/scale;
     
    minimize
     costBus40*nbBus40  +nbBus30*costBus30;
     
    subject to
    {
     40*nbBus40+nbBus30*30>=nbKids;
    }

    execute
    {
      writeln("nbBus40 = ",nbBus40);
      writeln("nbBus30 = ",nbBus30);
    }

/*
which gives

 

    nbBus40 = 7.75
    nbBus30 = 0

NB:

Many other examples at https://www.linkedin.com/pulse/making-decision-optimization-simple-alex-fleischer/

 */
