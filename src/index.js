
for (let j = 0; j < process.argv.length; j++) {  
    console.log(j + ' -> ' + (process.argv[j]));
}

console.log(process.env.s3FileKey)
console.log(process.env.s3BucketName)
console.log('batch job running ' + new Date())
