org.apache.hadoop.conf.Confuiguration;
org.apache.hadoop.conf.Confuigued;
org.apache.hadoop.mapreduce.lib.chain.ChainMapper;

//Configuration conf = getConf();
Configuration conf = new Configuration();

//JobConf job = new JobConf(conf);

Job job = new Job(conf);
job.setJarByClass(MaxTemperature.class);
job.setJobName("Max temperature");

FileInputFormat.addInputPath(job, new Path(args[0]));
FileOutputFormat.setOutputPath(job, new Path(args[1]));

//job.setJobName("ChainJob");
//job.setInputFormat(TextInputFormat.class);
//job.setOutputFormat(TextOutputFormat.class);

//FileInputFormat.setInputPaths(job, in); 
//FileOutputFormat.setOutputPath(job, out);

// ***********************************************************************************************
// Notes for configuring chain mappers
// http://hadoop.apache.org/docs/r2.8.5/api/org/apache/hadoop/mapreduce/lib/chain/ChainMapper.html
// ***********************************************************************************************

Configuration mapForFiltering=new Configuration(false);
ChainMapper.addMapper(job, NameOfmapperFilteringClass.class, InputKey.class, InputVal.class,OutputKey.class,OutputVal.class,mapForFiltering);

Configuration mapForKVPair=new Configuration(false);
ChainMapper.addMapper(job, NameOfmapperKVClass.class, InputKey.class, InputVal.class,OutputKey.class,OutputVal.class,mapForKVPair);

/*
JobConf map1Conf = new JobConf(false);
ChainMapper.addMapper(job,
                      Map1.class,
                      LongWritable.class,
                      Text.class,
                      Text.class,
                      Text.class,
                      true,
                      map1Conf);

JobConf map2Conf = new JobConf(false);
ChainMapper.addMapper(job,
                      BMap.class,
                      Text.class,
                      Text.class,
                      LongWritable.class,
                      Text.class,
                      true,
                      map2Conf);
 
JobConf reduceConf = new JobConf(false);
ChainReducer.setReducer(job,
                        Reduce.class,
                        LongWritable.class,
                        Text.class,
                        Text.class,
                        Text.class,
                        true,
                        reduceConf);

JobConf map3Conf = new JobConf(false);
ChainReducer.addMapper(job,
                       Map3.class,
                       Text.class,
                       Text.class,
                       LongWritable.class,
                       Text.class,
                       true,
                       map3Conf);

JobConf map4Conf = new JobConf(false);
ChainReducer.addMapper(job,
                       Map4.class,
                       LongWritable.class,`
                       Text.class,
                       LongWritable.class,
                       Text.class,
                       true,
                       map4Conf);
*/ 

// JobClient.runJob(job);
job.setMapperClass(MaxTemperatureMapper.class);
job.setReducerClass(MaxTemperatureReducer.class);

job.setOutputKeyClass(Text.class);
job.setOutputValueClass(IntWritable.class);

System.exit(job.waitForCompletion(true) ? 0 : 1);