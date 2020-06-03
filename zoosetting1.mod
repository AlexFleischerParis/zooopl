/*

let s go on with https://www.linkedin.com/pulse/what-optimization-how-can-help-you-do-more-less-zoo-buses-fleischer/

On top of model files (.mod) and data files (.dat) we can also add settings to tell CPLEX how to behave.

We have several options:

1) Through scripting in OPL
2) ops file
3) read ops file from flow control

*/

execute
{
  cplex.tilim=20;
}


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

execute
{
    writeln("time limit = ",cplex.tilim);
}

/*
which gives

 

    // solution (optimal) with objective 3800
    time limit = 20
*/
