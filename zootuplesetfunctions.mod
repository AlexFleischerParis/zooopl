/*

Tuple set is the main building block for data processing in OPL so let's see
many available functions both in OPL modeling part and scripting part

*/
    int nbKids=300;


    // a tuple is like a struct in C, a class in C++ or a record in Pascal
    tuple bus
    {
    key int nbSeats;   // number of seats is the key of the tuple bus
    float cost;
    }

    // This is a tuple set
    {bus} buses={<40,500>,<30,400>};
    
    // Let us see here what we can do with tuple sets
    
    int nbKindOfBuses=card(buses); // number of buses
    bus firstBus=first(buses);
    bus lastBus=last(buses);
    bus secondBus=item(buses,1);
    
    execute
    {
      writeln("nbKindOfBuses = ",nbKindOfBuses);
      writeln("firstBus = ",firstBus);
      writeln("lastBus = ",lastBus);
      writeln("secondBus = ",secondBus);
    }
    
    // Let us compute average cost
    
    float meanCost=sum(b in buses) b.cost/card(buses);
    
    execute
    {
      writeln("mean cost = ",meanCost);
    }
    
    {int} possibleSizes={b.nbSeats | b in buses};
    
    execute
    {
      writeln("possible sizes = ",possibleSizes);
      writeln();
    }
    
    // And now let us build arrays of costs per size
    
    float costPerSize[s in possibleSizes]=item(buses,<s>).cost;
    float costPerSize2[s in possibleSizes]=first({b | b in buses : b.nbSeats==s}).cost;
    float costPerSize3[possibleSizes]=[ b.nbSeats:b.cost | b in buses];
    
    float costPerSize4[possibleSizes];
    float costPerSize5[possibleSizes];
    float costPerSize6[possibleSizes];
    
    tuple buskey
    {
    int nbSeats;
    }
    buskey tempbus;
    
    execute
    {
      for(var s in possibleSizes) costPerSize4[s]=buses.find(s).cost;
      for(var b in buses) costPerSize5[b.nbSeats]=b.cost;
      
      for(var s in possibleSizes)
      {
        tempbus.nbSeats=s;
        costPerSize6[s]=Opl.item(buses,tempbus).cost;
      }
    }
    
    assert forall(s in possibleSizes) costPerSize[s]==costPerSize2[s];
    assert forall(s in possibleSizes) costPerSize[s]==costPerSize3[s];
    assert forall(s in possibleSizes) costPerSize[s]==costPerSize4[s];
    assert forall(s in possibleSizes) costPerSize[s]==costPerSize5[s];
    assert forall(s in possibleSizes) costPerSize[s]==costPerSize6[s];
    
    // And now let us change the prices , if price is less than 450 then *1.1 else *1.05
    
    {bus} newbuses={<nb,((p<=450)?1.1*p:1.05*p)> | <nb,p> in buses};
    
    {bus} newbuses2={b | b in buses};
    range rbuses=0..card(buses)-1;
    
    execute
    {
      for(var i in rbuses) 
         if (Opl.item(newbuses2,i).cost<=450)
          Opl.item(newbuses2,i).cost=Opl.item(newbuses2,i).cost*1.1;
         else 
            Opl.item(newbuses2,i).cost=Opl.item(newbuses2,i).cost*1.05;
    }
    
    {bus} newbuses3={b | b in buses};
    
    execute
    {
      function raise(x)
      {
        if (x.cost<=450) x.cost=1.1*x.cost; else x.cost=1.05*x.cost;
      }
      
      function apply(s,f)
      {
        for(var i=0;i<s.size;i++) f(Opl.item(s,i));
      }
      
      apply(newbuses3,raise);
    }
    
    execute
    {
      writeln("buses before the price raise");
      writeln(buses);
      writeln("buses after the price raise");
      writeln(newbuses);
    }
    
    assert forall(b in newbuses2) b in newbuses;
    assert forall(b in newbuses3) b in newbuses;
    
    {bus} additionalbuses={<20,2000>,<15,1500>};
    
    execute
    {
      for(var b in additionalbuses) newbuses.add(b);
      newbuses.add(100,10000);
    }
    
    // importSet adds all the elements from a set
    execute
    {
      newbuses3.importSet(additionalbuses);
    }
    
    assert card(newbuses3)==4;
    
    // add adds one tuple
    execute
    {
      newbuses3.add(100,10000);
    }
    
    execute
    {
      newbuses2=Opl.operatorUNION(newbuses2,additionalbuses);
      newbuses2.add(100,10000);
    }
    
    execute
    {
      writeln("buses after we add ",additionalbuses," and <100,10000>");
      writeln(newbuses2);
    }
    
    assert card(newbuses)==5;
    assert card(newbuses2)==5;
    assert card(newbuses3)==5;
    
    
    {bus} newbuses4=newbuses union additionalbuses union {<100,10000>};
    
    assert card(newbuses4)==5;
    
    assert <100,10000> in newbuses;
    assert <100,10000> not in buses;

    // asserts help make sure data is fine
    assert forall(b in newbuses) b.nbSeats>0;
    assert forall(b in newbuses) b.cost>0;

    // decision variable array
    dvar int+ nbBus[newbuses];

    // objective
    minimize
     sum(b in newbuses) b.cost*nbBus[b];
     
    // constraints
    subject to
    {
     sum(b in newbuses) b.nbSeats*nbBus[b]>=nbKids;
    }

    tuple result
    {
       key int nbSeats;
       int nbBuses;
    }

    {result} results={<b.nbSeats,nbBus[b]> | b in newbuses:nbBus[b]!=0};
    
    execute
    {
      writeln(results);
      writeln();
      for(var i in results) writeln(i.nbBuses," buses with ",i.nbSeats," seats");
    }

/*

which gives

nbKindOfBuses = 2
firstBus =  <40 500>
lastBus =  <30 400>
secondBus =  <30 400>
mean cost = 450
possible sizes =  {40 30}

buses before the price raise
 {<40 500> <30 400>}
buses after the price raise
 {<40 525> <30 440>}
buses after we add  {<20 2000> <15 1500>} and <100,10000>
 {<40 525> <30 440> <20 2000> <15 1500> <100 10000>}
// solution (optimal) with objective 4030
 {<40 6> <30 2>}

6 buses with 40 seats
2 buses with 30 seats

*/