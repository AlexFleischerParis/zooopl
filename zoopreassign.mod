int nbKids=300;

{int} seats={40,30}; // how many seats, {} means this is a set
float costBus[seats]=[500,400];

// Now let s see how preassign some decision variables
// Suppose we know that we have exactly 6 buses 40 seats

{int} preassignedseats={40};
int preassignedvalues[preassignedseats]=[6];

     
dvar int+ nbBus[s in seats] 
in 
((s in preassignedseats)?preassignedvalues[s]:0) 
.. 
((s in preassignedseats)?preassignedvalues[s]:maxint);

minimize sum(b in seats) costBus[b]*nbBus[b];
     
subject to
{
    sum(b in seats) b*nbBus[b]>=nbKids;
}
