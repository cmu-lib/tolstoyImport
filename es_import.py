#use this to bulk import json data 10/30/16. Remember to move this to folder you want to index.

from pyelasticsearch import ElasticSearch
import json
import os

ES_CLUSTER = 'http://localhost:9200/'
ES_INDEX = 'tolstoy'
ES_TYPE = 'diaries'
es = ElasticSearch(ES_CLUSTER)

json_docs = []
for filename in os.listdir(os.getcwd()):
    if filename.endswith('.json'):
        with open(filename) as open_file:
            json_docs.append(json.load(open_file))

es.bulk_index(ES_INDEX, ES_TYPE, json_docs)
