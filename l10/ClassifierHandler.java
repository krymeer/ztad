import java.lang.Math;
import java.util.Enumeration;
import java.util.Random;
import weka.core.Attribute;
import weka.core.Instance;
import weka.core.Instances;
import weka.classifiers.AbstractClassifier;
import weka.classifiers.Evaluation;

public class ClassifierHandler {
    private void printInstances(Instances instances) {
        for (Instance inst : instances)
        {
            System.out.println(inst);
        }
    }

    private double getMeanFromIntArray(int[] arr) {
        double mean = 0.0;
        int n       = arr.length;

        if (n > 0)
        {
            for (int a : arr)
            {
                mean += a;
            }

            mean /= n;
        }

        return mean;
    }

    public void testClassifier(Instances inputSet, String classifier, int classIndex, int numberOfFolds, int numberOfInstances, int numberOfExperiments) {
        boolean[] instancesUsed;
        boolean[] currentlyTested;
        AbstractClassifier absCls;
        Evaluation eval;
        Instances instances         = new Instances(inputSet);
        Instances testingSet;
        Instances trainingSet;
        Random rand;
        int tn, tp, fn, fp;
        int[] tpArr                 = new int[numberOfExperiments];
        int[] fpArr                 = new int[numberOfExperiments];
        int[] tnArr                 = new int[numberOfExperiments];
        int[] fnArr                 = new int[numberOfExperiments];
        int testingSetSize          = numberOfInstances / numberOfFolds;
        int trainingSetSize         = numberOfInstances - testingSetSize;
        String classifierOptions    = Appendix.getClassifierOptionsAsString(classifier);

        instances.setClassIndex(classIndex);

        for (int j = 0; j < numberOfExperiments; j++)
        {
            instancesUsed = new boolean[numberOfInstances];
            tn = 0; tp = 0; fn = 0; fp = 0;

            for (int k = 0; k < numberOfFolds; k++)
            {
                testingSet      = new Instances(instances, testingSetSize);
                trainingSet     = new Instances(instances, trainingSetSize);
                rand            = new Random();
                currentlyTested = new boolean[numberOfInstances];

                while (testingSetSize != testingSet.size())
                {
                    int index = rand.nextInt(numberOfInstances);

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
                    absCls  = Appendix.getClassifier(classifier);
                    eval    = new Evaluation(trainingSet);

                    absCls.buildClassifier(trainingSet);
                    eval.evaluateModel(absCls, testingSet);

                    tn += eval.numTrueNegatives(classIndex);
                    tp += eval.numTruePositives(classIndex);
                    fn += eval.numFalseNegatives(classIndex);
                    fp += eval.numFalsePositives(classIndex);
                }
                catch(Exception e)
                {
                    System.err.println();
                    e.printStackTrace();
                }
            }

            tpArr[j] = tp;
            fpArr[j] = fp;
            tnArr[j] = tn;
            fnArr[j] = fn;
        }

        double tpAvg        = getMeanFromIntArray(tpArr);
        double fpAvg        = getMeanFromIntArray(fpArr);
        double tnAvg        = getMeanFromIntArray(tnArr);
        double fnAvg        = getMeanFromIntArray(fnArr);
        double accuracy     = (tpAvg + tnAvg)/(tpAvg + tnAvg + fpAvg + fnAvg);
        double tnRate       = tnAvg/(tnAvg + fpAvg);
        double tpRate       = tpAvg/(tpAvg + fnAvg);
        double fpRate       = 1 - tnRate;
        double gMean        = Math.sqrt(tpRate * tnRate);
        double auc          = (1 + tpRate - fpRate) / 2;

        System.out.println("\nClassifier used: " + Appendix.getClassifierName(classifier));

        if (!classifierOptions.equals(""))
        {
            System.out.println("Classifier parameters set: " + classifierOptions);
        }

        System.out.println("\n#########################\n#                       #\n#        Results        #\n#                       #\n#########################\n");
        System.out.println("TP = " + tpAvg + "\t\tFN = " + fnAvg);
        System.out.println("FP = " + fpAvg + "\t\tTN = " + tnAvg);
        System.out.println("\nAccuracy\t= " + accuracy);
        System.out.println("TNrate\t\t= " + tnRate);
        System.out.println("TPrate\t\t= " + tpRate);
        System.out.println("GMean\t\t= " + gMean);
        System.out.println("AUC\t\t= " + auc);

        System.out.println("\n#########################\n#                       #\n#      Other stats      #\n#                       #\n#########################\n");
        System.out.println("Number of instances:\t\t" + numberOfInstances);
        System.out.println("Number of experiments:\t\t" + numberOfExperiments);
        System.out.println("Number of folds:\t\t" + numberOfFolds);
        System.out.println("Size of the training set:\t" + trainingSetSize);
        System.out.println("Size of the testing set:\t" + testingSetSize);

        Attribute classAttribute    = instances.classAttribute();
        Enumeration classValues     = classAttribute.enumerateValues();

        System.out.println("Class name:\t\t\t" + instances.classAttribute().name());
        System.out.print("Class values:\t\t\t");

        while (classValues.hasMoreElements())
        {
            System.out.print(classValues.nextElement());

            if (classValues.hasMoreElements())
            {
                System.out.print(", ");
            }
            else
            {
                System.out.println();
            }
        }

        System.err.println();
    }
}