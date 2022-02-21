
import java.io.IOException;
import java.util.StringTokenizer;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.mapreduce.TableMapper;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;
import org.apache.hadoop.hbase.client.*;
import org.apache.hadoop.hbase.mapreduce.TableMapReduceUtil;

public class HBaseMapReduceWordCount {



    private static class WordCountMapper extends TableMapper<Text, IntWritable> {

        private final static IntWritable one = new IntWritable(1);
        private Text word = new Text();

        public void map(ImmutableBytesWritable row, Result value, Context context) throws InterruptedException, IOException {
            Configuration conf = context.getConfiguration();
            String targetColFamilyName = conf.get("targetColFamilyName");
            String targetColQualifierName = conf.get("targetColQualifierName");

            String text = new String(value.getValue(Bytes.toBytes(targetColFamilyName), Bytes.toBytes(targetColQualifierName)));
            StringTokenizer itr = new StringTokenizer(text);
            while (itr.hasMoreTokens()) {
                word.set(itr.nextToken());
                context.write(word, one);
            }
        }
    }

    private static class WordCountReducer extends Reducer<Text,IntWritable,Text,IntWritable> {
        private IntWritable result = new IntWritable();

        public void reduce(Text key, Iterable<IntWritable> values, Context context) throws IOException, InterruptedException {
            int sum = 0;
            for (IntWritable val : values) {
                sum += val.get();
            }
            result.set(sum);
            context.write(key, result);
        }
    }

    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
        if (otherArgs.length != 4) {
            System.err.println("Usage: 3 required params <hbase_table_name> <col_family> <col_qualifier> <hdfs_output_path>");
            System.exit(2);
        }
        String inputTableName = otherArgs[0];
        String targetColFamilyName = otherArgs[1];
        String targetColQualifierName = otherArgs[2];
        // Parameters to Mapper or Reducers are passed through Context because they need to be distributed!
        conf.set("targetColFamilyName", targetColFamilyName);
        conf.set("targetColQualifierName",targetColQualifierName);

        System.out.println("--> Running wordcount from HBase table: " + inputTableName);
        System.out.println("--> Target column family: " + targetColFamilyName);
        System.out.println("--> Target column qualifier: " + targetColQualifierName);

        // Configure MapReduce job
        Job job = new Job(conf, "word count");
        job.setJarByClass(MapReduceWordCount.class);

        // Configure HBase scanner
        Scan scan = new Scan();
        scan.setCaching(500);        // 1 is the default in Scan, which will be bad for MapReduce jobs
        scan.setCacheBlocks(false);  // don't set to true for MR jobs

        // Use TableMapReduceUtil to create a wrapper around our Mapper function.
        // This will take care of the connection to HBase, once a table and a Scan object are provided.
        TableMapReduceUtil.initTableMapperJob(
                inputTableName,            // input table
                scan,                   // Scan instance to control CF and attribute selection
                WordCountMapper.class,  // mapper class
                Text.class,             // mapper output key
                IntWritable.class,      // mapper output value
                job);

        // Set combiner and reducers as usual
        job.setCombinerClass(WordCountReducer.class);
        job.setReducerClass(WordCountReducer.class);    // reducer class
        //job.setNumReduceTasks(1);    // at least one, adjust as required
        FileOutputFormat.setOutputPath(job, new Path(otherArgs[3]));
        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }

}