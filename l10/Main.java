import java.util.Arrays;
import weka.core.Instances;

public class Main {
    public static void main(String[] args) {
        ArffDataReader adr = new ArffDataReader();
        String[] classifiers = {"bayes", "jrip"};

        adr.handleArgs(args);

        if (adr.inputSet == null)
        {
            System.err.println("\nError: the input set is null\n");
            System.exit(0);
        }
        
        int numberOfInstances   = adr.inputSet.size();
        int numberOfAttributes  = adr.inputSet.numAttributes();

        if (numberOfInstances <= 0)
        {
            System.err.println("\nError: the input set is empty\n");
            System.exit(0);
        }

        if (!Arrays.stream(classifiers).anyMatch(adr.classifier::equals))
        {
            System.err.println("\nError: unknown classifier: \"" + adr.classifier + "\"");
            System.err.println("\nAvailable classifiers: ");

            for (int k = 0; k < classifiers.length-1; k++)
            {
                System.err.print("\"" + classifiers[k] + "\", ");
            }

            System.err.print("\"" + classifiers[classifiers.length-1] + "\"\n\n");
            System.exit(0);
        }

        if (adr.numberOfFolds < 0)
        {
            System.err.println("\nError: number of folds(" + adr.numberOfFolds + ") is smaller than 0\n");
            System.exit(0);
        }
        else if (adr.numberOfFolds > numberOfInstances)
        {
            System.err.println("\nError: number of folds (" + adr.numberOfFolds + ") is greater than number of instances (" + numberOfInstances + ")\n");
            System.exit(0);
        }

        if (adr.classIndex < 0)
        {
            System.err.println("\nError: number of folds(" + adr.classIndex + ") is smaller than 0\n");
            System.exit(0);
        }
        else if (adr.classIndex >= numberOfAttributes)
        {
            System.err.println("\nError: the class index (" + adr.classIndex + ") is greater than number of attributes (" + numberOfAttributes + ") for the given input set\n");
            System.exit(0);
        }
        else if (adr.numberOfExperiments < 1)
        {
            System.err.println("\nError: number of experiments (" + adr.numberOfExperiments + ") is smaller than the allowed minimum (1)\n");
            System.exit(0);
        }


        System.err.println("\nInfo: file loaded successfully");

        ClassifierHandler handler = new ClassifierHandler();
        handler.testClassifier(adr.inputSet, adr.classifier, adr.classIndex, adr.numberOfFolds, numberOfInstances, adr.numberOfExperiments);
    }
}