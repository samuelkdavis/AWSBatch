const AWS = require('aws-sdk');

var batch = new AWS.Batch(
    {
        apiVersion: '2016-08-10',
        region: 'ap-southeast-2'
    });

var jobDefinition = 'ai-batch-job-definition';
var jobName = 'Job' + getRandomInt(10000, 99999);
var jobQueue = 'ai-batch-queue';

var myJSONObject = {
    a: 'b',
    c: 'd',
    e: {
        f: 'h',
        a: 'b'
    }
};

var params = {
    jobDefinition: jobDefinition, 
    jobName: jobName, 
    jobQueue: jobQueue,        
    containerOverrides: {
        'environment': [
            {
                'name': 's3FileKey',
                'value': 'VALUE_1'
            },            
            {
                'name': 's3BucketName',
                'value': 'VALUE_2'
            },
            {
                'name': 'jsonObject',
                'value': JSON.stringify(myJSONObject)
            }
        ]
    }
   };
   batch.submitJob(params, function(err, data) {
     if (err) console.log(err, err.stack);
     else     console.log(data);
     /*
     data = {
      jobId: "876da822-4198-45f2-a252-6cea32512ea8", 
      jobName: "example"
     }
     */
   });

function getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min)) + min; //The maximum is exclusive and the minimum is inclusive
  }