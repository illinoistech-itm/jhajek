org.apache.hadoop.conf.Configuration;
org.apache.hadoop.conf.Configured;
org.apache.hadoop.mapreduce.lib.chain.ChainMapper;

Configuration conf = new Configuration();

Job job = new Job(conf);
job.setJarByClass(MaxTemperature.class);
job.setJobName("Max temperature");

FileInputFormat.addInputPath(job, new Path(args[0]));
FileOutputFormat.setOutputPath(job, new Path(args[1]));

// ***********************************************************************************************
// Notes for configuring chain mappers
// http://hadoop.apache.org/docs/r2.8.5/api/org/apache/hadoop/mapreduce/lib/chain/ChainMapper.html
// ***********************************************************************************************

Configuration mapForFiltering=new Configuration(false);
ChainMapper.addMapper(job, MaxTemperatureParse.class, LongWritable.class, Text.class,NullWritable.class,Text.class,mapForFiltering);


Configuration mapForKVPair=new Configuration(false);
ChainMapper.addMapper(job, MaxTemperatureFilteredMapper.class, LongWritable.class, Text.class,Text.class,IntWritable.class,mapForKVPair);


job.setMapperClass(MaxTemperatureMapper.class);
job.setReducerClass(MaxTemperatureReducer.class);

job.setOutputKeyClass(Text.class);
job.setOutputValueClass(IntWritable.class);

System.exit(job.waitForCompletion(true) ? 0 : 1);