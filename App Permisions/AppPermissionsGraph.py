import pandas as pd
import json

with open("googleplay-app-permission.json", encoding='utf-8') as json_file:
    appPermissions = pd.read_json(json_file, encoding='UTF-8')

print(appPermissions.head(10))