import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.util.List;
import java.util.ArrayList;
import weka.core.Attribute;
import weka.core.Instance;
import weka.core.Instances;

public class ArffDataReader {
    Instances inputSet;
    String classifier;
    String classifierOptions;
    int classIndex;
    int numberOfFolds;
    int numberOfExperiments;

    ArffDataReader() {
        this.inputSet               = null;
        this.classifier             = "";
        this.classifierOptions      = "";
        this.classIndex             = -1;
        this.numberOfFolds          = -1;
        this.numberOfExperiments    = -1;
    }

    private Instances reorderAttributeValues(Instances instances, String attrName, String[] attrValues) {
        Instances updatedInstances  = new Instances(instances);
        Attribute attribute         = updatedInstances.attribute(attrName);
        boolean properOrder         = true;
        int numberOfValues          = attrValues.length;

        if (attribute != null && attribute.isNominal() && numberOfValues == attribute.numValues())
        {
            for (int k = 0; k < numberOfValues; k++)
            {

                if (!attribute.value(k).equals(attrValues[k]))
                {
                    properOrder = false;
                    break;
                }
            }

            if (!properOrder)
            {
                List<String> list   = new ArrayList<String>(numberOfValues);
                int attrIndex       = attribute.ordering();

                for (String av : attrValues)
                {
                    list.add(av);
                }

                Attribute updatedAttribute = new Attribute(attrName + "_", list);

                updatedInstances.insertAttributeAt(updatedAttribute, attrIndex);

                for (Instance inst : updatedInstances)
                {
                    inst.setValue(attrIndex, inst.stringValue(attrIndex+1));
                }

                updatedInstances.deleteAttributeAt(attrIndex+1);
                updatedInstances.renameAttribute(attrIndex, attrName);
            }
        }

        return updatedInstances;
    }

    public void handleArgs(String[] args) {
        String filename = "";
        ArffDataReader adr = new ArffDataReader();

        if (args.length < 1 || (args.length % 2) > 0)
        {
            System.err.println("\nUsage: java -cp .:weka.jar Main -f filename -cls classifier -clop classifierOptions -ci classIndex -nf numberOfFolds -ne numberOfExperiments\n");
            System.exit(1);
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
            else if (args[k].equals("-ne"))
            {
                try
                {
                    this.numberOfExperiments = Integer.parseInt(args[k+1]);
                }
                catch(NumberFormatException e)
                {
                    System.err.println();
                    e.printStackTrace();
                }
            }
            else if (args[k].equals("-clop"))
            {
                this.classifierOptions = args[k+1].replaceAll("\\s{2,}", " ").trim();
            }
        }

        try
        {
            Reader reader       = new FileReader(filename);
            Instances instances = new Instances(reader);
            this.inputSet       = reorderAttributeValues(instances, "status pozyczki", new String[]{"zly", "dobry"});
        }
        catch(IOException e)
        {
            System.err.println();
            e.printStackTrace();
        }
    }
}