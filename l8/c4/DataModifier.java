/*
 * Osada Krzysztof, 2018
 */

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;

public class DataModifier
{
    /*
     * Sprawdzenie, czy ktorys z elementow tablicy ciagow jest podciagiem ciagu wejsciowego
     */
    public static Boolean containsAny(String str, String[] arr)
    {
        for (String a : arr)
        {
            if (str.indexOf(a) != -1)
            {
                return true;
            }
        }
        return false;
    }

    /*
     * Modyfikacja danych zgodnie z zalozeniami zadania
     */
    public static List<String> modifyData(List<String> lines, String filename)
    {
        String[] statusArr          = {};
        List<String> output         = new ArrayList<String>();
        int index                   = -1;
        int statusIndex             = -1; 
        int amountIndex             = -1; 

        for (String line : lines)
        {
            if (line.indexOf("@relation") != -1)
            {
                line = line.replace("XXXXXXL2 2", filename.replace(".arff", ""));
            }
            else if (line.indexOf("@attribute") != -1)
            {
                index++;

                if (line.indexOf("status pozyczki") != -1)
                {
                    statusIndex = index;
                    statusArr   = line.substring(1+line.indexOf("{"), line.indexOf("}")).split(","); 
                    continue;
                }
                else if (line.indexOf("kwota kredytu") != -1)
                {
                    amountIndex = index;
                }
            }
            else if (line.indexOf("odmowa") != -1)
            {
                continue;
            }
            else if (containsAny(line, statusArr))
            {
                String[] dataArray  = line.split(",");
                float val             = -1.0f;

                try
                {
                    val = Float.parseFloat(dataArray[amountIndex]);
                }
                catch(NumberFormatException e) {}

                if (val > 0 && val < 901)
                {
                    String s = dataArray[statusIndex];

                    if (statusIndex < index)
                    {
                        s += ",";
                    }

                    line = line.replace(s, "");
                }
                else
                {
                    continue;
                }
            }

            output.add(line); 
        }

        return output;
    }

    /*
     * Zapisanie danych do pliku o wskazanej nazwie
     */
    public static void saveData(List<String> lines, String filename)
    {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filename)))
        {
            for (String line : lines)
            {
                bw.write(line + "\n");
            }

            bw.close();
        }
        catch (IOException e)
        {
            System.err.println("\nBlad: zapis do pliku \"" + filename + "\" zakonczony niepowodzeniem (IOException)\n");
        }
    }

    /*
     * Pobranie zawartosci pliku (z podzialem na linie)
     */
    public static List<String> getFileContents(String filename)
    {
        List<String> lines = new ArrayList<String>();
        
        try (BufferedReader br = new BufferedReader(new FileReader(filename)))
        {
            String line;

            while ((line = br.readLine()) != null)
            {
                lines.add(line);
            }

            br.close();
        }
        catch (FileNotFoundException e)
        {
            System.err.println("\nBlad: plik \"" + filename + "\" nie istnieje\n");
            System.exit(0);
        }
        catch (IOException e)
        {
            System.err.println("\nBlad: IOException dla pliku \"" + filename + "\"\n");
        }

        return lines;
    }

    public static void main (String[] args)
    {
        if (args.length == 2)
        {
            List<String> fileLines = getFileContents(args[0]);

            if (fileLines.size() > 0)
            {
                fileLines = modifyData(fileLines, args[1]);
                saveData(fileLines, args[1]);
            }
            else
            {
                System.err.println("\nBlad: plik \"" + args[0] + "\" jest pusty\n");
            }
        }
        else
        {
            System.err.println("\nUzycie: java DataModifier nazwa_pliku_wejsciowego nazwa_pliku_wyjsciowego\n");
        }
    }
}