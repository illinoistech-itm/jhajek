// cc MaxTemperature Application to find the maximum temperature in the weather dataset
// vv MaxTemperature
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.mapreduce.lib.chain.ChainMapper;

public class MaxTemperatureChainCounter {

  public static void main(String[] args) throws Exception {
    if (args.length != 2) {
      System.err.println("Usage: MaxTemperature <input path> <output path>");
      System.exit(-1);
    }
    Configuration conf = new Configuration();
    Job job = new Job(conf);
    job.setJarByClass(MaxTemperatureChainCounter.class);
    job.setJobName("Max temperature Chain Mapper");

    FileInputFormat.addInputPath(job, new Path(args[0]));
    FileOutputFormat.setOutputPath(job, new Path(args[1]));

    Configuration mapForFiltering=new Configuration(false);
   ChainMapper.addMapper(job, MaxTemperatureMapperWithCounter.class, LongWritable.class, Text.class,NullWritable.class,Text.class,mapForFiltering);


  Configuration mapForKVPair=new Configuration(false);
 ChainMapper.addMapper(job, MaxTemperatureFilteredMapper.class, NullWritable.class, Text.class,Text.class,IntWritable.class,mapForKVPair);

    job.setMapperClass(MaxTemperatureMapperWithCounter.class);
    job.setReducerClass(MaxTemperatureReducer.class);

    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(IntWritable.class);

    System.exit(job.waitForCompletion(true) ? 0 : 1);
  }
}
// ^^ MaxTemperature
~                                                                                                                                                                                                                  ~                                                                                                                                                                                     