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
  40*nbBus40+nbBus30*30>=nbKids;
  
  // Plus let s add that numbers of buses have to be 3 multipliers
  
  nbBus40 mod 3==0;
  nbBus30 mod 3==0;
}

/*

which gives

nbBus40 = 3;
nbBus30 = 6;

*/
