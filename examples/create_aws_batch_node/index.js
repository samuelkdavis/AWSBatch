const AWS = require('aws-sdk');

var batch = new AWS.Batch(
    {
        apiVersion: '2016-08-10',
        region: 'ap-southeast-2'
    });

var jobDefinition = 'ai-batch-job-definition';
var jobName = 'Job' + getRandomInt(10000, 99999);
var jobQueue = 'ai-batch-queue';

var params = {
    jobDefinition: jobDefinition, 
    jobName: jobName, 
    jobQueue: jobQueue,        
    containerOverrides: {
        'environment': [
            {
                'name': 'ENVVAR1',
                'value': 'VALUE_1'
            },            
            {
                'name': 'ENVVAR2',
                'value': 'VALUE_2'
            },
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