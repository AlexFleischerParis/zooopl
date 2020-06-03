 include "visu.mod";

int nbKids=300;

{int} nbKidsOptions={nbKids+i*10 | i in -10..2};
int x2[i in 1..card(nbKidsOptions)]=item(nbKidsOptions,i-1);
int y2[i in 1..card(nbKidsOptions)];

float costBus40=500;
float costBus30=400;
 
dvar int+ nbBus40;
dvar int+ nbBus30;
 
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

main
{
thisOplModel.generate();
var k=1;
for(var nbKids in thisOplModel.nbKidsOptions)

{
writeln("if we need to bring ",nbKids," kids  to the zoo");
    
thisOplModel.ctKids.LB=nbKids;

cplex.solve();
thisOplModel.postProcess();
writeln("And the cost is ",cplex.getObjValue());
thisOplModel.y2[k]=cplex.getObjValue();
k++;
writeln();
}

var pythonpath="C:\\Python36\\python.exe";
var pythonfile="C:\\temp\\displayXY.py";
displayXY(thisOplModel.x2,thisOplModel.y2,pythonpath,pythonfile,"cost=f(number of kids)","number of kids","cost");

 

 

} 

     

     
/*
 

and you will get

    if we need to bring 200 kids  to the zoo
    nbBus40 = 5
    nbBus30 = 0
    And the cost is 2500

    if we need to bring 210 kids  to the zoo
    nbBus40 = 3
    nbBus30 = 3
    And the cost is 2700

    if we need to bring 220 kids  to the zoo
    nbBus40 = 4
    nbBus30 = 2
    And the cost is 2800

    if we need to bring 230 kids  to the zoo
    nbBus40 = 5
    nbBus30 = 1
    And the cost is 2900

    if we need to bring 240 kids  to the zoo
    nbBus40 = 6
    nbBus30 = 0
    And the cost is 3000

    if we need to bring 250 kids  to the zoo
    nbBus40 = 4
    nbBus30 = 3
    And the cost is 3200

    if we need to bring 260 kids  to the zoo
    nbBus40 = 5
    nbBus30 = 2
    And the cost is 3300

    if we need to bring 270 kids  to the zoo
    nbBus40 = 6
    nbBus30 = 1
    And the cost is 3400

    if we need to bring 280 kids  to the zoo
    nbBus40 = 7
    nbBus30 = 0
    And the cost is 3500

    if we need to bring 290 kids  to the zoo
    nbBus40 = 5
    nbBus30 = 3
    And the cost is 3700

    if we need to bring 300 kids  to the zoo
    nbBus40 = 6
    nbBus30 = 2
    And the cost is 3800

    if we need to bring 310 kids  to the zoo
    nbBus40 = 7
    nbBus30 = 1
    And the cost is 3900

    if we need to bring 320 kids  to the zoo
    nbBus40 = 8
    nbBus30 = 0
    And the cost is 4000
    
    */

