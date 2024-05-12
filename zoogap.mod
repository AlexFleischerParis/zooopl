execute
 {
   cplex.intsollim=2;
 }

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
} 

execute
{
  writeln("nbbus40 = ",nbBus40);
  writeln("nbbus30 = ",nbBus30);
  writeln("obj =",cplex.getObjValue());
  writeln("best obj =",cplex.getBestObjValue());
  writeln("gap = ",(Math.abs(
  cplex.getBestObjValue()-cplex.getObjValue()))/(Math.abs(1e-10+cplex.getObjValue())));
  writeln("gap = ",cplex.getMIPRelativeGap());
}

/*

// solution (solution limit exceeded) with objective 3900
nbbus40 = 7
nbbus30 = 1
obj =3900
best obj =3750
gap = 0.038461538

*/







