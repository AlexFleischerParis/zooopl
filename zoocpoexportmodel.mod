/*

let us continue https://www.linkedin.com/pulse/making-decision-optimization-simple-alex-fleischer/

*/

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
} 

main
{
  thisOplModel.generate();
  cp.exportModel("zoo.cpo");
  
}

/*

which will build some files like zoo.cpo

Minternals {
  version(22.1.2.0);
  architecture("x64_windows_msvc14/stat_mda", 64);
}

// ------ Integer variables: ------------------------------------------------

nbBus40 = intVar(0..intmax);
nbBus30 = intVar(0..intmax);

// ------ Objective: --------------------------------------------------------

minimize(scalProd([500, 400], [nbBus40, nbBus30]));

// ------ Constraints: ------------------------------------------------------

scalProd([40, 30], [nbBus40, nbBus30]) >= 300;


// ------ Internal data: ----------------------------------------------------

internals {
  ids(0..10);
}


*/
