/*
 
 Now suppose we want to have different quantities for each bus size



And we can write:

*/

    using CP;
    int nbKids=120;
    float costBus40=400;
    float costBus30=300;
    float costBus50=500;
         
    dvar int+ nbBus40;
    dvar int+ nbBus30;
    dvar int+ nbBus50;

    
    
         
    minimize
      costBus40*nbBus40  +nbBus30*costBus30+nbBus50*costBus50;
         
    subject to
    {
     
     

      40*nbBus40+nbBus30*30+nbBus50*50>=nbKids;
      
      // all different constraint
      allDifferent(append(nbBus30,nbBus40,nbBus50));
    }
    
/*

which gives

// solution with objective 1300
nbBus40 = 0;
nbBus30 = 1;
nbBus50 = 2;


*/    
