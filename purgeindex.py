
import json
import time
import datetime
import boto3
import decimal
import os
import requests 
from requests_aws4auth import AWS4Auth

#Setup Elastic Search Connection Details
session =  boto3.session.Session()
credentials = session.get_credentials()
service='es'
region = 'AWS_REGION'
ES_URL = "http://" + 'ES_ENDPOINT'
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key, region, service, session_token=credentials.token)

#Delete status data
path = "/stationsstatus/_delete_by_query"
url = ES_URL + '' + path
jsonData = '{"query": {"match_all":{}}}'
jsonData = json.loads(jsonData)
headers = {'Content-Type': 'application/json', 'Accept': 'text/plain'}
req = requests.post(url=url,data=json.dumps(jsonData),headers=headers,  auth=awsauth)
print(req.text)
