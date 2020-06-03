

    int nbKids=...;
    float costBus40=...;
    float costBus30=...;

    int maxBus40=...;
    int maxBus30=...;
         
    dvar int+ nbBus40 in 0..maxBus40;
    dvar int+ nbBus30 in 0..maxBus30;
         
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

