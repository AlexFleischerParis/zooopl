    int nbKids=300;
    
    {int} buses={30,40,50};
    
    
    dvar int+ nbBus[buses];
    dvar int maxNbOfBusesGivenSize;
    
        
    minimize maxNbOfBusesGivenSize;
         
    subject to
    {
     // logical constraint
     // maxNbOfBusesGivenSize is the max of all nbBus
     maxNbOfBusesGivenSize==max(i in buses) nbBus[i];
     sum(i in buses) i*nbBus[i]>=nbKids;
    }

    execute DISPLAY_After_SOLVE
    {
      writeln("The max number of buses is ",maxNbOfBusesGivenSize);
      writeln("nbBus = ",nbBus);
    }
    
    /*
    
    gives
    
    The max number of buses is 3
    nbBus =  [3 3 3]
    
    */
