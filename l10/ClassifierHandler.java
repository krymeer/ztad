import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.lang.Math;
import java.util.Enumeration;
import java.util.Random;
import weka.core.Attribute;
import weka.core.Instance;
import weka.core.Instances;
import weka.classifiers.AbstractClassifier;
//import weka.classifiers.Evaluation;

public class ClassifierHandler {
    private void printInstances(Instances instances) {
        for (Instance inst : instances)
        {
            System.err.println(inst);
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

    public void testClassifier(Instances inputSet, String classifier, String classifierOptions, int classIndex, int numberOfFolds, int numberOfInstances, int numberOfExperiments) {
        boolean[] instancesUsed;
        boolean[] currentlyTested;
        AbstractClassifier absCls;
        //Evaluation eval;
        Instances instances         = new Instances(inputSet);
        Instances testingSet;
        Instances trainingSet;
        Random rand;
        int tn, tp, fn, fp, instancesUsedNum;
        int testingSetSize          = 0;
        int trainingSetSize         = 0;
        int[] tpArr                 = new int[numberOfExperiments];
        int[] fpArr                 = new int[numberOfExperiments];
        int[] tnArr                 = new int[numberOfExperiments];
        int[] fnArr                 = new int[numberOfExperiments];

        instances.setClassIndex(classIndex);

        for (int j = 0; j < numberOfExperiments; j++)
        {

            testingSetSize      = numberOfInstances / numberOfFolds;
            trainingSetSize     = testingSetSize * (numberOfFolds - 1);
            instancesUsed       = new boolean[numberOfInstances];
            instancesUsedNum    = 0;
            tn = 0; tp = 0; fn = 0; fp = 0;

            for (int k = 0; k < numberOfFolds; k++)
            {
                if (k == numberOfFolds - 1 && (numberOfInstances - instancesUsedNum) > testingSetSize)
                {
                    testingSetSize = (numberOfInstances - instancesUsedNum);
                }

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
                        instancesUsedNum++;
                        testingSet.add(instances.get(index));
                    }
                }

                int i = 0;

                while (trainingSetSize != trainingSet.size())
                {
                    if (!currentlyTested[i])
                    {
                        trainingSet.add(instances.get(i));
                    }

                    i++;
                }

                try
                {
                    absCls  = Appendix.getClassifier(classifier, classifierOptions);
                    //eval    = new Evaluation(trainingSet);

                    absCls.buildClassifier(trainingSet);

                    for( Instance inst : testingSet )
                    {
                        double realValue        = inst.value(classIndex); 
                        double predictedValue   = absCls.classifyInstance(inst);

                        if (realValue == 1 && predictedValue == 1) // TP
                        {
                            tp++;
                        }
                        else if (realValue == 0 && predictedValue == 1) // FP
                        {
                            fp++;
                        }
                        else if (realValue == 0 && predictedValue == 0) // TN
                        {
                            tn++;
                        }
                        else if (realValue == 1 && predictedValue == 0) // FN
                        {
                            fn++;
                        }
                    }

                /*
                 * Testowanie klasyfikatora przy uzyciu ewaluatora
                 * (zastapione przez zliczanie reczne)
                 */
                //    eval.evaluateModel(absCls, testingSet);

                //    tn += eval.numTrueNegatives(classIndex);
                //    tp += eval.numTruePositives(classIndex);
                //    fn += eval.numFalseNegatives(classIndex);
                //    fp += eval.numFalsePositives(classIndex);
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

        double tpAvg    = getMeanFromIntArray(tpArr);
        double fpAvg    = getMeanFromIntArray(fpArr);
        double tnAvg    = getMeanFromIntArray(tnArr);
        double fnAvg    = getMeanFromIntArray(fnArr);
        double accuracy = (tpAvg + tnAvg)/(tpAvg + tnAvg + fpAvg + fnAvg);
        double tnRate   = tnAvg/(tnAvg + fpAvg);
        double tpRate   = tpAvg/(tpAvg + fnAvg);
        double fpRate   = 1 - tnRate;
        double gMean    = Math.sqrt(tpRate * tnRate);
        double auc      = (1 + tpRate - fpRate) / 2;
        String pathStr  = "out/";
        Path path       = Paths.get(pathStr);
        String filename = pathStr + classifier.toLowerCase() + "_results.txt";

        if (Files.notExists(path))
        {
            try
            {
                Files.createDirectories(path);
            }
            catch(IOException e)
            {
                System.err.println();
                e.printStackTrace();
            }
        }

        try (PrintWriter out = new PrintWriter(filename))
        {
            out.println("#####################################\n#                                   #\n#   (c) 2018-2019 Osada Krzysztof   #\n#                                   #\n#####################################");
            out.println("\nClassifier used:\n" + Appendix.getClassifierName(classifier));

            if (!classifierOptions.equals(""))
            {
                out.println("\nAssumed classifier parameters set:\n" + classifierOptions);
            }

            out.println("\n\n#####################################\n#                                   #\n#              Results              #\n#                                   #\n#####################################\n");

            out.println("Confusion matrix [TP FN / FP TN]:");
            out.println(tpAvg + "\t" + fnAvg);
            out.println(fpAvg + "\t" + tnAvg + "\n");
            out.println("ACC   = " + accuracy);
            out.println("TNR   = " + tnRate);
            out.println("TPR   = " + tpRate);
            out.println("AUC   = " + auc);
            out.println("GMean = " + gMean);

            out.println("\n\n#####################################\n#                                   #\n#            Other stats            #\n#                                   #\n#####################################");
            out.println("\nNumber of instances:\n" + numberOfInstances);
            out.println("\nNumber of experiments:\n" + numberOfExperiments);
            out.println("\nNumber of folds:\n" + numberOfFolds);
            out.println("\nSize of the training set:\n" + trainingSetSize);
            out.println("\nSize of the testing set:\n" + testingSetSize);

            Attribute classAttribute    = instances.classAttribute();
            Enumeration classValues     = classAttribute.enumerateValues();

            out.println("\nClass name:\n" + instances.classAttribute().name());
            out.print("\nClass values:\n");

            while (classValues.hasMoreElements())
            {
                out.print(classValues.nextElement());

                if (classValues.hasMoreElements())
                {
                    out.print(", ");
                }
            }

            out.close();

            System.err.println("Info: file \"" + filename + "\" has been created");
        }
        catch(FileNotFoundException e)
        {
            System.err.println();
            e.printStackTrace();
        }

        System.err.println();
    }
}