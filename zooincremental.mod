/*

Quite often, after solving the model we need to add new variables and constraints. We can do that by writing new models but we can also do this incrementally.

Suppose we need to first know what will happen if we need to have same number of 40 seats and 30 seats buses and then allow 50 seats buses in the model.

We can write

    int nbKids=300;
    float costBus40=500;
    float costBus30=400;
    float costBus50=700;
     
    dvar int+ nbBus40;
    dvar int+ nbBus30;
    dvar int+ nbBus50;

     
    minimize
     costBus40*nbBus40  +nbBus30*costBus30+nbBus50*costBus50;
     
    subject to
    {
     ctKids:40*nbBus40+nbBus30*30+nbBus50*50>=nbKids;
     
     nbBus30==nbBus40;
     nbBus50==0;
    }

    execute DISPLAY_After_SOLVE
    {
    writeln("The minimum cost is ",costBus40*nbBus40  +nbBus30*costBus30+costBus50*nbBus50);
    writeln("We will use ",nbBus40," 40 seats buses ",nbBus30," 30 seats buses and ",
    nbBus50," buses 50 seats");
    }

which will give

 

    The minimum cost is 4500
    We will use 5 40 seats buses 5 30 seats buses and 0 buses 50 seats

and then if we comment

     nbBus50==0;

which means we allow 50 seats buses then we ll get

 

    The minimum cost is 4100
    We will use 3 40 seats buses 3 30 seats buses and 2 buses 50 seats

But to do that we generate 3 times the matrix which can take time.

 

We can do that in a main and be incremental. And then we do not generate new matrixes but rely on incremental changes.

The technique is simply to have spare decision variables and constraints:

*/

 

    int nbKids=300;
    float costBus40=500;
    float costBus30=400;
     
    dvar int+ nbBus40;
    dvar int+ nbBus30;
    dvar int+ emptyVar;
     
    minimize
     costBus40*nbBus40  +nbBus30*costBus30;
     
    subject to
    {
     ctKids:40*nbBus40+nbBus30*30>=nbKids;
     
     ctEmpty:0<=0;

    }

    execute DISPLAY_After_SOLVE
    {
    writeln("The minimum cost is ",costBus40*nbBus40  +nbBus30*costBus30);
    writeln("We will use ",nbBus40," 40 seats buses and ",nbBus30," 30 seats buses ");
    writeln();
    }

    main
    {
    thisOplModel.generate();

    writeln("Basic model");

    cplex.solve();
    thisOplModel.postProcess();

    writeln("Let us add a row : saying that nbBus40 and nbBus30 should be equal");

    thisOplModel.ctEmpty.setCoef(thisOplModel.nbBus40,1);
    thisOplModel.ctEmpty.setCoef(thisOplModel.nbBus30,-1);
    thisOplModel.ctEmpty.setBounds(0,0);
    cplex.solve();
    thisOplModel.postProcess();

    writeln("Let us add a column : saying that nbBus50 could also be used and their cost is 700");
    cplex.setObjCoef(thisOplModel.emptyVar,700);
    thisOplModel.ctKids.setCoef(thisOplModel.emptyVar,50);
    cplex.solve();
    writeln("The minimum cost is ",
    thisOplModel.costBus40*thisOplModel.nbBus40.solutionValue  +thisOplModel.nbBus30.solutionValue*thisOplModel.costBus30
    +700*thisOplModel.emptyVar.solutionValue);
    writeln("We will use ",thisOplModel.nbBus40.solutionValue," 40 seats buses ",thisOplModel.nbBus30.solutionValue,
    " 30 seats buses and "+thisOplModel.emptyVar.solutionValue," 50 seats buses");
    }

/*
gives

 

    Basic model
    The minimum cost is 3800
    We will use 6 40 seats buses and 2 30 seats buses

    Let us add a row : saying that nbBus40 and nbBus30 should be equal
    The minimum cost is 4500
    We will use 5 40 seats buses and 5 30 seats buses

    Let us add a column : saying that nbBus50 could also be used and their cost is 700
    The minimum cost is 4100
    We will use 3 40 seats buses 3 30 seats buses and 2 50 seats buses

Of course we get the same results. 

*/
