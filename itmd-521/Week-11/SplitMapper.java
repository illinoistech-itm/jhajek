import java.io.IOException;
import java.util.StringTokenizer;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class SplitMapper extends Mapper<LongWritable, Text, Text, IntWritable> {
              @Override
              protected void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
                             StringTokenizer tokenizer = new StringTokenizer(value.toString());
                             IntWritable dummyValue = new IntWritable(1);
                             while (tokenizer.hasMoreElements()) {
                                           String content = (String) tokenizer.nextElement();
                                           context.write(new Text(content), dummyValue);
                             }
              }
}