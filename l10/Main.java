import weka.core.Instances;

public class Main {
    public static void main(String[] args) {
        ArffDataReader adr = new ArffDataReader();

        adr.handleArgs(args);

        if (adr.inputSet == null)
        {
            System.err.println("\nError: the input set is null\n");
            System.exit(1);
        }
        
        int numberOfInstances   = adr.inputSet.size();
        int numberOfAttributes  = adr.inputSet.numAttributes();

        if (numberOfInstances <= 0)
        {
            System.err.println("\nError: the input set is empty\n");
            System.exit(1);
        }

        int classifierIndex = Appendix.getClassifierIndex(adr.classifier);

        if (classifierIndex < 0)
        {
            System.err.println("\nError: unknown classifier: \"" + adr.classifier + "\"");
            System.err.println("\nAvailable classifiers: ");

            String[] classifiers = Appendix.getAllClassifiersNames();

            for (int k = 0; k < classifiers.length-1; k++)
            {
                System.err.print("\"" + classifiers[k] + "\", ");
            }

            System.err.print("\"" + classifiers[classifiers.length-1] + "\"\n\n");
            System.exit(1);
        }
        else
        {
            adr.classifier = Appendix.getClassifierName(adr.classifier);
        }

        if (adr.numberOfFolds < 0)
        {
            System.err.println("\nError: number of folds(" + adr.numberOfFolds + ") is smaller than 0\n");
            System.exit(1);
        }
        else if (adr.numberOfFolds > numberOfInstances)
        {
            System.err.println("\nError: number of folds (" + adr.numberOfFolds + ") is greater than number of instances (" + numberOfInstances + ")\n");
            System.exit(1);
        }

        if (adr.classIndex < 0)
        {
            System.err.println("\nError: number of folds(" + adr.classIndex + ") is smaller than 0\n");
            System.exit(1);
        }
        else if (adr.classIndex >= numberOfAttributes)
        {
            System.err.println("\nError: the class index (" + adr.classIndex + ") is greater than number of attributes (" + numberOfAttributes + ") for the given input set\n");
            System.exit(1);
        }
        else if (adr.numberOfExperiments < 1)
        {
            System.err.println("\nError: number of experiments (" + adr.numberOfExperiments + ") is smaller than the allowed minimum (1)\n");
            System.exit(1);
        }


        System.err.println("\nInfo: file loaded successfully");

        ClassifierHandler handler = new ClassifierHandler();
        handler.testClassifier(adr.inputSet, adr.classifier, adr.classifierOptions, adr.classIndex, adr.numberOfFolds, numberOfInstances, adr.numberOfExperiments);
    }
}