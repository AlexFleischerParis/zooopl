 // Now let's see how easy it is to write if then else constraints :

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
     
     // with if nb buses 40 more than 3  then nb buses30 more than 7
     
     (nbBus40>=3)=>(nbBus30>=7);
     //(nbBus40>=3)<=(nbBus30>=7); //equivalent
    }
     
/*
which gives

 

    nbBus40 = 0;
    nbBus30 = 10;
    
    */

