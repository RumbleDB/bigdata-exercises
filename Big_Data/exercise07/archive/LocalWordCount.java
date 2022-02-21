import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;


public class LocalWordCount {

    private static void count(String in, String out) {
        long startTime = System.currentTimeMillis();
        TreeMap<String, Integer> counter = new TreeMap<>();

        try {

            // Read
            BufferedReader br = new BufferedReader(new FileReader(in));
            String line;
            while ((line = br.readLine()) != null) {
                StringTokenizer itr = new StringTokenizer(line);
                while (itr.hasMoreTokens()) {
                    String w = itr.nextToken();
                    counter.put(w, counter.get(w) != null ? counter.get(w) + 1 : 1);
                }
            }

            // Write keeping ordering
            PrintWriter writer = new PrintWriter(out, "UTF-8");
            for(Map.Entry<String,Integer> entry : counter.entrySet()) {
                String key = entry.getKey();
                Integer value = entry.getValue();
                writer.println(key + "\t" + value);
            }
            writer.close();

            long endTime = System.currentTimeMillis();
            double duration = (endTime - startTime) / 1000.0;
            System.out.println("Done in " + duration + " seconds");
        }
        catch (Exception e) {
            System.err.println(e.getMessage());
            System.exit(1);
        }
    }


    public static void main(String[] args) {
        if (args.length != 2) {
            System.err.println("Usage: 2 required params <local_file_in> <local_file_out>");
            System.exit(2);
        }
        count(args[0], args[1]);
    }
}