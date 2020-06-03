/*

let s now deal with a new information : for a given bus size if we take more than 4 then we get a 20% discount.

This moves our function cost from linear to piecewise linear. Let's have a look at how to deal with this in OPL.

 

We would then write:

*/

 

    int nbKids=300;
    float costBus40=500;
    float costBus30=400;

    // If we take more than 4 buses for a given size, 20% cheaper for additional buses
     
    dvar int+ nbBus40;
    dvar int+ nbBus30;

    pwlFunction pricePerQuantity=piecewise{1->4;0.8};

    assert forall(k in 1..4 ) pricePerQuantity(k)==k;
    assert forall(k in 5..10) as:abs(pricePerQuantity(k)-4-(k-4)*0.8)<=0.00001;
     
    minimize
     costBus40*pricePerQuantity(nbBus40)  +pricePerQuantity(nbBus30)*costBus30;
     
    subject to
    {
     40*nbBus40+nbBus30*30>=nbKids;
    }

/*
which gives 10 buses 30 seats and no 40 seats bus.

Not a huge discount but this gives a strong incentive to change and use more 30 seats buses.

regards

PS: Many other very simple examples at https://www.linkedin.com/pulse/making-decision-optimization-simple-alex-fleischer/ 

*/
