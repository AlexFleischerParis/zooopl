/*

For some models solution pool does not work so here let's see
how to manage without solution pools

*/

int nbiter=5;
range iter=1..nbiter;

int nbKids=300;
float costBus40=500;
float costBus30=400;

dvar int+ nbBus40;
dvar int+ nbBus30;

// Not to get again those previous solutions
dvar int nbBus40prevSol[1..nbiter];
dvar int nbBus30prevSol[1..nbiter];
 
minimize
 costBus40*nbBus40^2  +nbBus30^2*costBus30;
 
subject to
{
 40*nbBus40+nbBus30*30>=nbKids;
 
 forall(i in iter) (nbBus40!=nbBus40prevSol[i]) || (nbBus30!=nbBus30prevSol[i]);
} 

execute
{
  writeln(nbBus40," buses 40 seats and ",nbBus30," buses 30 seats");
  writeln("cost : ",cplex.getObjValue());
}

main
{
  thisOplModel.generate();
  for(var i in thisOplModel.iter)
  {
    cplex.solve();
    thisOplModel.postProcess();
    var sol40=thisOplModel.nbBus40.solutionValue;
    var sol30=thisOplModel.nbBus30.solutionValue;
    thisOplModel.nbBus40prevSol[i].UB=sol40;
    thisOplModel.nbBus40prevSol[i].LB=sol40;
    thisOplModel.nbBus30prevSol[i].UB=sol30;
    thisOplModel.nbBus30prevSol[i].LB=sol30;
    
  }
  
  
  1;
}

/*

which gives

4 buses 40 seats and 5 buses 30 seats
cost : 18000
5 buses 40 seats and 4 buses 30 seats
cost : 18900
3 buses 40 seats and 6 buses 30 seats
cost : 18900
6 buses 40 seats and 2 buses 30 seats
cost : 19600
6 buses 40 seats and 3 buses 30 seats
cost : 21600

*/

