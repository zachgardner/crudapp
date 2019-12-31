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
region = os.environ['AWS_REGION']
ES_ENDPOINT = "http://" + os.environ['ES_ENDPOINT'] 
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key, region, service, session_token=credentials.token)

#Delete All Indices
path = "/*"
url = ES_ENDPOINT + '' + path
headers = {'Content-Type': 'application/json', 'Accept': 'text/plain'}
req = requests.delete(url=url, headers=headers, auth=awsauth)
print(req.text)

#Station Details Index Put
path='/stationdetails'
url = ES_ENDPOINT + '' + path
print(url)
values = '{"settings":{"number_of_shards":3,"number_of_replicas":2},"mappings":{"fromFirehose1":{"properties":{"date":{"type":"date"},"eightd_has_available_keys":{"type":"text"},"is_installed":{"type":"integer"},"is_renting":{"type":"integer"},"is_returning":{"type":"integer"},"last_reported":{"type":"integer"},"num_bikes_available":{"type":"integer"},"num_bikes_disabled":{"type":"integer"},"num_docks_available":{"type":"integer"},"num_docks_disabled":{"type":"integer"},"num_ebikes_available":{"type":"integer"},"station_id":{"type":"integer"},"time":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}}}}}}'
values = json.loads(values)
req = requests.put(url=url, data=json.dumps(values), headers=headers, auth=awsauth)
print(req.text)

#Station Index Put
path='/stations'
url = ES_ENDPOINT + '' + path
values = '{"settings":{"number_of_shards":3,"number_of_replicas":2},"mappings":{"fromFirehose":{"properties":{"capacity":{"type":"long"},"eightd_has_key_dispenser":{"type":"boolean"},"eightd_station_services":{"properties":{"bikes_availability":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"description":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"docks_availability":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"id":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"link_for_more_info":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"name":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"schedule_description":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"service_type":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}}}},"electric_bike_surcharge_waiver":{"type":"boolean"},"external_id":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"has_kiosk":{"type":"boolean"},"lat":{"type":"float"},"location":{"properties":{"lat":{"type":"geo_point"},"lon":{"type":"geo_point"}}},"lon":{"type":"float"},"name":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"region_id":{"type":"long"},"rental_methods":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"rental_url":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"short_name":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}},"station_id":{"type":"text","fields":{"keyword":{"type":"keyword","ignore_above":256}}}}}}}'
values = json.loads(values)
req = requests.put(url=url, data=json.dumps(values),  headers=headers, auth=awsauth)

dynamodb = boto3.resource('dynamodb', region_name=region)
client = boto3.client('firehose', region_name=region)
STATION_DETAIL_TABLE =  os.environ['STATION_DETAIL_TABLE']
STATION_DETAIL_DATA_URL =  os.environ['STATION_DETAIL_DATA_URL']
ES_FIREHOSE_STREAM_NAME_STATION_INFO = os.environ['FIREHOSE_STREAM_NAME_STATION_INFO']
detailTable = dynamodb.Table(STATION_DETAIL_TABLE)
stationDataURL = requests.get(STATION_DETAIL_DATA_URL)

stations = json.loads(stationDataURL.text)
for station in stations['data']['stations']:
        station = json.dumps(station)
        client.put_record(DeliveryStreamName=ES_FIREHOSE_STREAM_NAME_STATION_INFO, Record={'Data': json.dumps(station)})
        str_station = str(station).replace('""', '"NONE"').replace("\'", "\"").replace('False', '"False"').replace('True', '"True"')
        json_station = json.loads(str_station,parse_float=decimal.Decimal)
        response = detailTable.put_item(TableName=STATION_DETAIL_TABLE,Item=json_station)

