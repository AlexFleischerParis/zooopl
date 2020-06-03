/* 
 
 we handled what if analysis and dealt with many options with regards to the number of kids we need to bring to the zoo.

But now let's suppose all those options have some probabilities and we need to book buses the day before but in real time in the morning we may book some additional buses with an extra price. (+10%)

This is stochastic optimization. We want to minimize average cost. We call extra buses recourse variables.

In OPL, it is quite simple to move from a deterministic model to a stochastic model:

*/

 

    int nbKids=300;

    {int} nbKidsScenarii={nbKids+i*10 | i in -10..2};
    float proba[nbKidsScenarii]=[ 1, 1, 2, 2, 2 ,3 ,3 ,4,  5 ,10 ,50 ,10, 7];

    assert sum(s in nbKidsScenarii) proba[s]==100; // total probability is 100

    float costBus40=500;
    float costBus30=400;

    float costIncreaseIfLastMinute=1.1;

    // number of buses booked in advance
    dvar int+ nbBus40;
    dvar int+ nbBus30;
    // number of buses booked at the last minute which is far more expensive
    // we call those recourse decision
    dvar int+ nbBus40onTop[nbKidsScenarii] ;
    dvar int+ nbBus30onTop[nbKidsScenarii] ;
     
    minimize
     costBus40*nbBus40  +nbBus30*costBus30
     +
    1/100*costIncreaseIfLastMinute*
    sum(nbKids in nbKidsScenarii) proba[nbKids]*(costBus40*nbBus40onTop[nbKids]  +nbBus30onTop[nbKids]*costBus30);
     
    subject to
    {


     forall(nbKids in nbKidsScenarii)
       ctKids:40*(nbBus40+nbBus40onTop[nbKids])+(nbBus30+nbBus30onTop[nbKids])*30>=nbKids;
    }

    execute
    {
    writeln("nbBus40 = ",nbBus40);
    writeln("nbBus30 = ",nbBus30);
    writeln();
    writeln("nbBus40 on top = ",nbBus40onTop);
    writeln("nbBus30 on top = ",nbBus30onTop);
    }

/*
gives

 

    // solution (optimal) with objective 3775.5
    nbBus40 = 6
    nbBus30 = 0

    nbBus40 on top =  [0 0 0 0 0 0 0 0 1 0 0 1 2]
    nbBus30 on top =  [0 0 0 0 0 1 1 1 0 2 2 1 0]

 

Note that if we do not use recourse variables then we hedge against the worst case:

 

    dvar int+ nbBus40onTop[nbKidsScenarii] in 0..0;
    dvar int+ nbBus30onTop[nbKidsScenarii] in 0..0;

will give

 

    // solution (optimal) with objective 4000
    nbBus40 = 8
    nbBus30 = 0

    nbBus40 on top =  [0 0 0 0 0 0 0 0 0 0 0 0 0]
    nbBus30 on top =  [0 0 0 0 0 0 0 0 0 0 0 0 0]

 

which is more expensive (4000 vs 3775.5)

 

We should also compare the stochastic model with a naive approach : set the buses for the most probable scenario (300 kids) and then book extra buses

 

    dvar int+ nbBus40 in 6..6;
    dvar int+ nbBus30 in 2..2;

and then we get

    // solution (optimal) with objective 3874.8

    nbBus40 = 6
    nbBus30 = 2

    nbBus40 on top =  [0 0 0 0 0 0 0 0 0 0 0 0 0]
    nbBus30 on top =  [0 0 0 0 0 0 0 0 0 0 0 1 1]

which is more expensive (3874.8 vs 3775.5)

 

 

So in a nutshell, stochastic optimization can save money and is quite easy in OPL. 

*/
