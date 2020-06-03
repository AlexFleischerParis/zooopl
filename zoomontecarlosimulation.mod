 /*
 
 Monte Carlo techniques use random in order to help useful information.

 

For instance, by picking a random point in a square we can compute PI

 

    int n=10000000;
     int m=1000;
     range r=1..n;
     
     int x[i in r]=rand(m);
     int y[i in r]=rand(m);
     
     float pi=sum(i in r) (x[i]*x[i]+y[i]*y[i]<=m*m)*4/n;
     
     execute
     {
     writeln("Monte Carlo =",pi);
     writeln("PI =",Math.PI);
     }

gives

    Monte Carlo =3.145299999
    PI =3.141592654

Monte Carlo simulation is about using Monte Carlo do simulations and then get insights.

 

For the bus and zoo example, suppose the school needs to know on average how much money should be kept for the trip to the zoo. (Very useful in budgeting activities)

Then we run a few scenarii, pick the cheapest buses and compute the mean.

*/ 

    int nbKids=300;
     
    int nbMaxKidsAbsent=30;
     
    int nbSamples=20;
    range samples=1..nbSamples;
     
    int nbKidsLess[i in 1..nbSamples]=rand(nbMaxKidsAbsent); // uniform distribution

    int nbKidsOptions[i in samples]=nbKids-nbKidsLess[i];

    float costBus40=500;
    float costBus30=400;

    // To compute the average cost per kid of each bus
    // you may use OPL modeling language

    float averageCost40=costBus40/40;
    float averageCost30=costBus30/30;

    // naïve computation, use the cheapest bus

    float cheapestCostPerKid=minl(averageCost40,averageCost30);
    int cheapestBusSize=(cheapestCostPerKid==averageCost40)?40:30;
    float cheapestBusCost=(cheapestCostPerKid==averageCost40)?costBus40:costBus30;

    int nbBusNeeded[i in samples]=ftoi(ceil(nbKidsOptions[i]/cheapestBusSize));

    float cost[i in samples]=cheapestBusCost*nbBusNeeded[i];

    execute DISPLAY
    {

    writeln("cost = ",cost);
    writeln();
    }

    float averageCost=1/nbSamples*sum(i in samples) cost[i];

    execute
    {
    writeln("------------------------------");
    writeln("average cost = ",Math.ceil(averageCost));
    }

/*
gives

 

    average cost = 3825
    
    */
