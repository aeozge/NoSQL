#!/usr/bin/env bash

#Add your curl statements here

HOST="http://couchdb:5984"
curl $HOST

#Create restaurant db
curl -X PUT $HOST/restaurants

curl -i -X POST http://couchdb:5984/restaurants -H "Content-Type: application/json" -d '{"_id": "kebab", "name": "Hasan_Usta_Kebab", "food_type":["Turkish", "Kebab", "Traditional"], "phonenumber": "+902164180101", "website":"https://www.hasanustakebap.com"}'

curl -i -X POST http://couchdb:5984/restaurants -H "Content-Type: application/json" -d '{"_id": "mcdonalds", "name": "McDonalds", "food_type":["American", "Hamburger", "Casual"], "phonenumber": "8002446227", "website":"https://www.mcdonalds.com"}'

curl -i -X POST http://couchdb:5984/restaurants -H "Content-Type: application/json" -d '{"_id": "olive_garden", "name": "Olive_Garden", "food_type":["Italian", "Pasta", "Traditional"], "phonenumber": "8003312729", "website":"https://www.olivegarden.com"}'



#DO NOT REMOVE
curl -Ssf -X PUT http://couchdb:5984/restaurants/_design/docs -H "Content-Type: application/json" -d '{"views": {"all": {"map": "function(doc) {emit(doc._id, {rev:doc._rev, name:doc.name, food_type:doc.food_type, phonenumber:doc.phonenumber, website:doc.website})}"}}}'
curl -Ssf -X GET http://couchdb:5984/restaurants/_design/docs/_view/all
