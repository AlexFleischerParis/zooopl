 /*
 
 Now let's see how easy it is to write disjunctions like the number of  buses 40 seats should either be less than 3 or more than 7:


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
     40*nbBus40+nbBus30*30>=nbKids;

    //with nb buses 40 less than 3 or more than 7
    (nbBus40<=3) || (nbBus40>=7);
    }

/*
which gives

 

    nbBus40 = 7;
    nbBus30 = 1;
    
    */

