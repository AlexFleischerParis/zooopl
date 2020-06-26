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

execute
{
    writeln("nbBus40 = ",nbBus40," and nbBus30 = ",nbBus30," and the cost is ",costBus40*nbBus40  +nbBus30*costBus30);
}



main
{
cp.param.SearchType=24;
cp.param.workers=1;

thisOplModel.generate();
cp.startNewSearch();
while
(cp.next()) {  thisOplModel.postProcess(); }
} 

/*

which gives

nbBus40 = 0 and nbBus30 = 10 and the cost is 4000
nbBus40 = 3 and nbBus30 = 6 and the cost is 3900
nbBus40 = 6 and nbBus30 = 2 and the cost is 3800


*/



    


