// cc MaxTemperatureMapper Mapper for maximum temperature example
// vv MaxTemperatureMapper
import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class MaxTemperatureMapperCSV
  extends Mapper<LongWritable, Text, Text, Text> {

  
  @Override
  public void map(LongWritable key, Text value, Context context)
      throws IOException, InterruptedException {
    
    String line = value.toString();
    //String csvline = new String(line.substring(0,4).concat(",").concat(line.substring(4,10))); 
String csvline = new String(line.substring(0,4).concat("\t").concat(line.substring(4,10)).concat("\t").concat(line.substring(10,15)).concat("\t").concat(line.substring(15,23)).concat("\t").concat(line.substring(23,27)).concat("\t").concat(line.substring(27,28)).concat("\t").concat(line.substring(27,33)).concat("\t").concat(line.substring(33,40)).concat("\t").concat(line.substring(40,45)).concat("\t").concat(line.substring(45,49)).concat("\t").concat(line.substring(49,54)).concat("\t").concat(line.substring(54,59)).concat("\t").concat(line.substring(59,62)).concat("\t").concat(line.substring(62,63)).concat("\t").concat(line.substring(63,64)).concat("\t").concat(line.substring(64,68)).concat("\t").concat(line.substring(68,69)).concat("\t").concat(line.substring(69,70)).concat("\t").concat(line.substring(70,75)).concat("\t").concat(line.substring(75,76)).concat("\t").concat(line.substring(76,77)).concat("\t").concat(line.substring(77,83)).concat("\t").concat(line.substring(83,84)).concat("\t").concat(line.substring(84,85)).concat("\t").concat(line.substring(85,86)).concat("\t").concat(line.substring(86,91)).concat("\t").concat(line.substring(92,93)).concat("\t").concat(line.substring(93,98)).concat("\t").concat(line.substring(99,100)).concat("\t").concat(line.substring(100,105)).concat("\t").concat(line.substring(105,105)));
    String year = line.substring(15, 19);
      context.write(new Text(year), new Text(csvline));
  }
}
// ^^ MaxTemperatureMapper
