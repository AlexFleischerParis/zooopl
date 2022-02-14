 // Now let's see how easy it is to write if then else constraints when the condition is static :

    int nbKids=300;
    float costBus40=500;
    float costBus30=400;
    int schoolwithminimum9buses=1;


     
    dvar int+ nbBus40;
    dvar int+ nbBus30;

    minimize
     costBus40*nbBus40  +nbBus30*costBus30;
     
    subject to
    {
     40*nbBus40+nbBus30*30>=nbKids;
     
     
     
     if (schoolwithminimum9buses==1)
     (nbBus30>=9);
     else 
     nbBus40+nbBus30>=0; 
     
    }
    
    /*
    
    which gives
    
    nbBus40 = 0;
    nbBus30 = 10;
    
    but if the static condition is 0 then we get
    
    nbBus40 = 6;
	nbBus30 = 2;
    
    */
