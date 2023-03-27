import json
import boto3
import os
from datetime import datetime

s3 = boto3.resource('s3')

def lambda_handler(event,code):
    bucket_list = []
    count = 0
    for bucket in s3.buckets.all():
        bucket_list.append(bucket.name)
        count+=1
    bucket_list = str(bucket_list).replace("[", "").replace("]", "").replace(",", "").replace("'","").replace(" ",",")
    time_now = str(datetime.now()).replace("[", "").replace("]","").replace(",","").replace("'","").replace(" ",",")
    return {
        "headers": {'Content-Type': 'text/html',
        "bucket_names": bucket_list,
        "bucket_count": count,
        "time_date":    time_now }
        }
