/*

let us continue https://www.linkedin.com/pulse/making-decision-optimization-simple-alex-fleischer/

Suppose we want to be able to deal with more than 2 categories. For this, let us move from scalar to arrays.

*/



int nbKids=...;

{int} seats=...; // how many seats, {} means this is a set
float costBus[seats]=...;

     
dvar int+ nbBus[seats];

minimize sum(b in seats) costBus[b]*nbBus[b];
     
subject to
{
    sum(b in seats) b*nbBus[b]>=nbKids;
}

