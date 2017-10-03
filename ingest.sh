#!/bin/sh
# this works with letters and the updated json files. Not diaries or old json files. 10/17

# 0. loop through folders and python ingest scripts
ES_HOST=localhost:9200
for JSON_FILE_IN in /Users/user/Documents/dh_mellon/tolstoy/colloquy/parsed/letters/*.json; do
for JSON_FILE_OUT in /Users/user/Documents/dh_mellon/tolstoy/colloquy/parsed/output/$(basename "$JSON_FILE_IN" .json).json;
do
PYTHON="import json,sys;
out = open('$JSON_FILE_OUT', 'w');
with open('$JSON_FILE_IN') as json_in:
    docs = json.loads(json_in.read());
    for doc in docs:
        out.write('%s\n' % json.dumps({'index': {}}));
        out.write('%s\n' % json.dumps(doc, indent=0).replace('\n', ''));
"
done

# 1. run the Python script from step 0
python -c "$PYTHON"

# 2. use the output file from step 1 in the curl command
curl -s -XPOST $ES_HOST/tolstoy/type/_bulk --data-binary @$JSON_FILE_OUT

done
