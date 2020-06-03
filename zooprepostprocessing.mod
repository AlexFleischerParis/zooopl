/*

Let us use the example from https://www.linkedin.com/pulse/what-optimization-how-can-help-you-do-more-less-zoo-buses-fleischer/

OPL is a descriptive language but we can also add some javascript code before and after the solve takes place. We use the keyword execute for that and we call those preprocessing and postprocessing.

*/
    int nbKids=300;
    float costBus40=500;
    float costBus30=400;

    // Preprocessing

    execute DISPLAY_BEFORE_SOLVE
    {
    writeln("The challenge is to bring ",nbKids," kids to the zoo.");
    writeln("We can use 40 and 30 seats buses and the costs are ",costBus40," and ",costBus30);
    writeln("So average cost per kid are ",costBus40/40, " and ",costBus30/30);
    }

    // Decision variables , the unknown

    dvar int+ nbBus40;
    dvar int+ nbBus30;

    // Objective
     
    minimize
     costBus40*nbBus40  +nbBus30*costBus30;
     
    // Constraints
     
    subject to
    {
     40*nbBus40+nbBus30*30>=nbKids;
    }

    // Postprocessing

    execute DISPLAY_After_SOLVE
    {
    writeln("The minimum cost is ",costBus40*nbBus40  +nbBus30*costBus30);
    writeln("We will use ",nbBus40," 40 seats buses and ",nbBus30," 30 seats buses ");
    }

/*
gives

    The challenge is to bring 300 kids to the zoo.
    We can use 40 and 30 seats buses and the costs are 500 and 400
    So average cost per kid are 12.5 and 13.333333333
    // solution (optimal) with objective 3800
    The minimum cost is 3800
    We will use 6 40 seats buses and 2 30 seats buses

regards

Many other very simple examples at https://www.linkedin.com/pulse/making-decision-optimization-simple-alex-fleischer/ 

*/
