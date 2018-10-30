import java.io.IOException;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class LowerCaseMapper extends Mapper<Text, IntWritable, Text, IntWritable> {

              @Override
              protected void map(Text key, IntWritable value, Context context) throws IOException, InterruptedException {
                             String val = key.toString().toLowerCase();
                             Text newKey = new Text(val);
                             context.write(newKey, value);
              }
}