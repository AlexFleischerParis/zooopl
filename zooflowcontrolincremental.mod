/* 
 
 we saw in zooprepostprocessing that in OPL we can write some javascript code before and after the solve and we call those pre and post processing.

We can also call many times the CPLEX solvers and use scripting for that.

We then write a main block instead of an execute block.

Let me share a tiny example where we slightly do incremental changes to the model and then solve again and again.

*/

    int nbKids=300;
    float costBus40=500;
    float costBus30=400;
     
    dvar int+ nbBus40;
    dvar int+ nbBus30;
     
    minimize
     costBus40*nbBus40  +nbBus30*costBus30;
     
    subject to
    {
     ctKids:40*nbBus40+nbBus30*30>=nbKids;
    }

    execute
    {
    writeln("nbBus40 = ",nbBus40);
    writeln("nbBus30 = ",nbBus30);
    }

    main
    {
    thisOplModel.generate();

    cplex.solve();
    thisOplModel.postProcess();

    //now 350 kids instead of 300
    writeln("now 350 kids instead of 300");
        
    thisOplModel.ctKids.LB=350;

    cplex.solve();
    thisOplModel.postProcess();


    // no more than 4 buses 40 seats
    writeln("no more than 4 buses 40 seats");

    thisOplModel.nbBus40.UB=4;

    cplex.solve();
    thisOplModel.postProcess();

    // change the objective so that cost for 40 seats is 450
    // and remove the limit on the number of buses 40 seats

    writeln("change the objective so that cost for 40 seats is 450");
    writeln("and remove the limit on the number of buses 40 seats");    

    thisOplModel.nbBus40.UB=1000;
    cplex.setObjCoef(thisOplModel.nbBus40,450);
    cplex.setObjCoef(thisOplModel.nbBus30,400);

    cplex.solve();
    thisOplModel.postProcess();

     


    }

/*

which gives

 

    nbBus40 = 6
    nbBus30 = 2
    now 350 kids instead of 300
    nbBus40 = 8
    nbBus30 = 1
    no more than 4 buses 40 seats
    nbBus40 = 2
    nbBus30 = 9
    change the objective so that cost for 40 seats is 450
    and remove the limit on the number of buses 40 seats
    nbBus40 = 8
    nbBus30 = 1

regards

 

NB:

1) Those who look for for advanced tricks could visit https://www.linkedin.com/pulse/how-opl-alex-fleischer/

2) Many OPL users know they may call their OPL model from C++, JAVA, .NET, .... when there is no main block in their OPL model. Not that many know that they can call directly the main block from C++, JAVA, .NET using simply main()!

 

PS:

 

Many other very simple OPL models at https://www.linkedin.com/pulse/making-decision-optimization-simple-alex-fleischer/ 

*/
