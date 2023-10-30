import requests
import json
import mysql.connector

# Connect to your MySQL database
db = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="LMS-1"
)

# Set up the API endpoint and key
endpoint = "https://language.googleapis.com/v1/documents:analyzeEntities"
api_key = "AIzaSyA-KgUOoeLNsrdni6BPQHh2BuMBBoZnGtk"

# Set up the headers for the API request
headers = {"Content-Type": "application/json"}

# Retrieve data from your database
cursor = db.cursor()
query = "SELECT quiz_name FROM lms_quiz"
cursor.execute(query)
rows = cursor.fetchall()

# Get the mapping_name types from the database
mapping_query = "SELECT mapping_name FROM lms_mapping where formation_id=2"
cursor.execute(mapping_query)
mapping_rows = cursor.fetchall()

# Create a dictionary to map entity types to mapping names
type_mapping = {}
for row in mapping_rows:
    type_mapping[row[0]] = []

# Iterate through each row in the result set and analyze named entities
for row in rows:
  data = {
    "document": {
      "type": "PLAIN_TEXT",
      "content": row[0]
    },
    "encodingType": "UTF8"
  }
  
  # Send the API request using the requests library
  response = requests.post(f"{endpoint}?key={api_key}", headers=headers, data=json.dumps(data))

  # Parse the response to extract the entities
  response_json = response.json()
  entities = response_json.get("entities", [])

  # Categorize the entities according to the mapping names
  for entity in entities:
      entity_type = entity['type']
      for mapping_name, types in type_mapping.items():
          if entity_type in types or entity_type == mapping_name:
              types.append(entity_type)
              break

# Output the entities for each mapping name
for mapping_name, types in type_mapping.items():
    print(f"Named entities for mapping name {mapping_name}:")
    for entity_type in types:
        print(f"- Entity type: {entity_type}")
