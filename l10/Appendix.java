import java.util.Arrays;
import weka.classifiers.AbstractClassifier;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.functions.MultilayerPerceptron;
import weka.classifiers.functions.SMO;
import weka.classifiers.rules.JRip;
import weka.classifiers.rules.ZeroR;
import weka.classifiers.trees.J48;

public class Appendix {
    private static String[] classifiers = {"JRip", "J48", "MultilayerPerceptron", "NaiveBayes", "SMO", "ZeroRule"};

    public static String[] getAllClassifiersNames() {
        return classifiers;
    }

    public static String getClassifierName(String s) {
        for (String cls : classifiers)
        {
            if (cls.toLowerCase().equals(s.toLowerCase()))
            {
                return cls;
            }
        }

        return "";
    }

    public static int getClassifierIndex(String s) {
        for (int k = 0; k < classifiers.length; k++)
        {
            if (classifiers[k].toLowerCase().equals(s.toLowerCase()))
            {
                return k;
            }
        }

        return -1;
    }

    public static AbstractClassifier getClassifier(String name, String options) {
        AbstractClassifier abstractClassifier = null;
        String[] opts   = options.split(" ");
        int index       = getClassifierIndex(name);

        if (index >= 0)
        {
            if (name.equals("NaiveBayes"))
            {
                abstractClassifier = new NaiveBayes();
            }
            else if (name.equals("J48"))
            {
                abstractClassifier  = new J48();
            }
            else if (name.equals("JRip"))
            {
                abstractClassifier  = new JRip();
            }
            else if (name.equals("MultilayerPerceptron"))
            {
                abstractClassifier = new MultilayerPerceptron();
            }
            else if (name.equals("SMO"))
            {
                abstractClassifier = new SMO();
            }
            else if (name.equals("ZeroRule"))
            {
                abstractClassifier = new ZeroR();
            }

            try
            {
                abstractClassifier.setOptions(opts);
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
        }

        return abstractClassifier;
    }
}