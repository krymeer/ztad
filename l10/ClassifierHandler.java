import java.util.Random;
import weka.core.Instance;
import weka.core.Instances;
import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import weka.classifiers.bayes.NaiveBayesUpdateable;

public class ClassifierHandler {
    private Classifier getClassifier(String name) {
        if (name.equals("bayes"))
        {
            return new NaiveBayesUpdateable();
        }
        
        return null;
    }

    public void testClassifier(Instances inputSet, String classifier, int classIndex, int numberOfFolds, int numberOfInstances) {
        boolean[] instancesUsed = new boolean[numberOfInstances];
        boolean[] currentlyTested;
        Classifier cls;
        Evaluation eval;
        Instances instances = new Instances(inputSet);
        Instances testingSet;
        Instances trainingSet;
        int testingSetSize  = numberOfInstances / numberOfFolds;
        int trainingSetSize = numberOfInstances - testingSetSize;
        Random rand;

        instances.setClassIndex(classIndex);

        for (int k = 0; k < numberOfFolds; k++)
        {
            testingSet      = new Instances(instances, testingSetSize);
            trainingSet     = new Instances(instances, trainingSetSize); 
            rand            = new Random();
            currentlyTested = new boolean[numberOfInstances];

            while (testingSetSize != testingSet.size())
            {
                int index = rand.nextInt(testingSetSize + 1);

                if (!instancesUsed[index])
                {
                    currentlyTested[index]  = true;
                    instancesUsed[index]    = true;
                    testingSet.add(instances.get(index));
                }
            }

            for (int i = 0; i < numberOfInstances; i++)
            {
                if (!currentlyTested[i])
                {
                    trainingSet.add(instances.get(i));
                }
            }

            try
            {
                cls = getClassifier(classifier);
                eval = new Evaluation(trainingSet);

                cls.buildClassifier(trainingSet);
                eval.evaluateModel(cls, testingSet);

                System.err.println(eval.toSummaryString("\nResults\n======\n", false));
                System.err.println("FP: " + eval.numFalsePositives(1));
                System.err.println("FN: " + eval.numFalseNegatives(1));
                System.err.println("TP: " + eval.numTruePositives(1));
                System.err.println("TN: " + eval.numTrueNegatives(1));
                System.err.println();
            }
            catch(Exception e)
            {
                System.err.println();
                e.printStackTrace();
            }
            
            if (k == 0)
                break;
        }
    }
}