console.log('batch job running ' + new Date())
const aws = require('aws-sdk');


var s3FileKey = process.env.s3FileKey;
var s3BucketName = process.env.s3BucketName;

const s3 = new aws.S3();

var getParams = {
    Bucket: s3BucketName,
    Key: s3FileKey
}

s3.getObject(getParams, function(err, data) {
    if (err){
        console.log('error getting s3 object ' + err)
        return err;
    }
  let objectData = data.Body.toString('utf-8');
  console.log(objectData);
});

console.log('batch job finished')


