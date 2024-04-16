 /*
 
 Now suppose we need to move 200 kids to the zoo but on top of the cost objective we have a second level objective : minimize CO2 emission.

We call this lexicographic multi objective.



And we can write:

*/

   using CP;

    int nbKids=200;
    float costBus40=500;
    float costBus30=400;
    float costBus50=625;
         
    dvar int+ nbBus40 in 0..10;
    dvar int+ nbBus30 in 0..10;
    dvar int+ nbBus50 in 0..10;

    dvar int cost;
    dvar int co2emission;
         
    minimize
      staticLex(cost,co2emission);
         
    subject to
    {
     cost==costBus40*nbBus40  +nbBus30*costBus30+nbBus50*costBus50;
     co2emission==nbBus50*10+nbBus40*11+nbBus30*12;

      40*nbBus40+nbBus30*30+nbBus50*50>=nbKids;
    }

    execute DISPLAY_After_SOLVE
    {
      writeln("The minimum cost is ",cost);
      writeln("CO2 emission is ",co2emission/10);
      writeln("We will use ",nbBus40," 40 seats buses ",nbBus30,
      " 30 seats buses and ", nbBus50," buses 50 seats");
    }

 /*

which gives

 

    The minimum cost is 2500
    CO2 emission is 4
    We will use 0 40 seats buses 0 30 seats buses and 4 buses 50 seats

If we had used 5 buses 40 seats, the cost would have been 2500 also but the CO2 emission would have been bigger.

regards

NB: Til CPLEX 12.8 that was possible only with CP models, and since 12.9 this works also for mathematical models.

PS: Many other simple examples at https://www.linkedin.com/pulse/making-decision-optimization-simple-alex-fleischer/ 

*/
