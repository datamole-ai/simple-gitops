from os.path import exists
from os import environ
from sys import exit

import yaml

key = environ.get('KEY')
new_value = environ.get('NEW_VALUE') 
values_file = environ.get('VALUES_FILE')
values_file_path = values_file('VALUES_FILE_PATH')

print(values_file_path+values_file)

if exists(values_file):
  with open(values_file) as file:
    data = yaml.safe_load(file)
else:
  print("⚠️ Values file does not exist."); exit(1)
  

for elem in data:
  if key in data[elem]:
    key_found = True
    key_path = data[elem]

try: 
  if key_found:
    key_path[key] = new_value

except NameError:
  print("⚠️ Key not found."); exit(1)


with open(values_file, 'w') as file:
  yaml.dump(data, file, sort_keys=False)

