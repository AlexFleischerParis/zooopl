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

    cp.solve();
    thisOplModel.postProcess();

    //now 350 kids instead of 300
    writeln("now 350 kids instead of 300");
        
    thisOplModel.ctKids.LB=350;

    cp.solve();
    thisOplModel.postProcess();


    // no more than 4 buses 40 seats
    writeln("no more than 4 buses 40 seats");

    thisOplModel.nbBus40.UB=4;

    cp.solve();
    thisOplModel.postProcess();

    // change the objective so that cost for 40 seats is 450
    // and remove the limit on the number of buses 40 seats

    writeln("change the objective so that cost for 40 seats is 450");
    writeln("and remove the limit on the number of buses 40 seats");    

    thisOplModel.nbBus40.UB=1000;
    thisOplModel.generate();
    thisOplModel.getObjective().setCoef(thisOplModel.nbBus40,450);
    thisOplModel.getObjective().setCoef(thisOplModel.nbBus30,400);
    
   

    cp.solve();
    thisOplModel.postProcess();

     


    }
    
/*

gives

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


*/    
