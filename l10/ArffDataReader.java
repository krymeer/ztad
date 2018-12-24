import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import weka.core.Instances;

public class ArffDataReader {
    Instances inputSet;
    String classifier;
    int classIndex;
    int numberOfFolds;

    ArffDataReader() {
        this.inputSet       = null;
        this.classifier     = "";
        this.classIndex     = -1;
        this.numberOfFolds  = -1;
    }

    public void handleArgs(String[] args) {
        String filename = "";
        ArffDataReader adr = new ArffDataReader();

        if (args.length < 1)
        {
            System.err.println("\nUsage: java -cp .:weka.jar Main -f filename -cls classifier -ci classIndex -nf numberOfFolds\n");
            System.exit(0);
        }

        for (int k = 0; k < args.length-1; k++)
        {
            if (args[k].equals("-f"))
            {
                filename = args[k+1];
            }
            else if (args[k].equals("-cls"))
            {
                this.classifier = args[k+1];
            }
            else if (args[k].equals("-ci"))
            {
                try
                {
                    this.classIndex = Integer.parseInt(args[k+1]);
                }
                catch(NumberFormatException e)
                {
                    System.err.println();
                    e.printStackTrace();
                }

            }
            else if (args[k].equals("-nf"))
            {
                try
                {
                    this.numberOfFolds = Integer.parseInt(args[k+1]);
                }
                catch(NumberFormatException e)
                {
                    System.err.println();
                    e.printStackTrace();
                }
            }
        }

        try
        {
            Reader reader   = new FileReader(filename);
            this.inputSet   = new Instances(reader); 
        }
        catch(IOException e)
        {
            System.err.println();
            e.printStackTrace();
        }
    }
}

// TODO

/*
    System.out.println("testSet: " + testSet.size());

    for (int i = 0; i < testSetSize; i++)
    {
        System.out.println(testSet.get(i));
    }

    System.out.println("\ntrainingSet: " + trainingSet.size());

    for (int i = 0; i < trainingSetSize; i++)
    {
        System.out.println(trainingSet.get(i));
    }
*/