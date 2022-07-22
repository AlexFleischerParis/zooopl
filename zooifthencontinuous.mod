 // Now let's see how easy it is to write if then else constraints :

    int nbKids=600;
    float costBus40=500;
    float costBus30=400;


     
    dvar float+ nbBus40;
    dvar float+ nbBus30;

    minimize
     costBus40*nbBus40  +nbBus30*costBus30;
     
    subject to
    {
     40*nbBus40+nbBus30*30>=nbKids;
     
     // with if nb buses 40 more than 3  then nb buses30 more than 7
     
     (nbBus40>=3)=>(nbBus30>=7);
     //(nbBus40>=3)<=(nbBus30>=7); //equivalent
    }
    
    /*
    
    gives
    
    nbBus40 = 9.75;
    nbBus30 = 7;
    
    */
