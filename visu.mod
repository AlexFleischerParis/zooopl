

    execute
    {

    // turn an OPL array into a python list
        function getPythonListOfArray(_array)
        {

        var quote="\"";
        var nextline="\\\n";


        var res="[";
        for(var i in _array)
        {
        var value=_array[i];

        if (typeof(value)=="string") res+=quote;
        res+=value;
        if (typeof(value)=="string") res+=quote;
        res+=",";
        res+=nextline;
        }
        res+="]";
        return res;
        }

        // Display a function with points with x and y arrays of x and y
        function displayXY(x,y,pythonpath,pythonfile,graphName,xName,yName)
        {
        writeln("displayXY ",x," ",y," ",pythonpath," ",pythonfile);

        var python=new IloOplOutputFile(pythonfile);
        python.writeln("import matplotlib.pyplot as plt");
        python.writeln("x = ",getPythonListOfArray(x))
        python.writeln("y = ",getPythonListOfArray(y))
        python.writeln("plt.plot(x, y)");
        python.writeln("plt.xlabel('",xName,"')");
        python.writeln("plt.ylabel('",yName,"')");
        python.writeln("plt.title('",graphName,"')");
        python.writeln("plt.show()");
        python.close();
        IloOplExec(pythonpath+" "+ pythonfile,true);        
        }
        }

