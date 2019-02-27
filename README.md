## ZSSN (REST API)

REST API for [ZSSN (Zombie Survival Social Network](https://gist.github.com/akitaonrails/711b5553533d1a14364907bbcdbee677) problem. 
Developed in Ruby on Rails (v5.2.2) and Sqlite3 (v1.3.6)

# Instalation

1. Download or clone the repository
2. To install the dependencies, run
```
bundle install

```
(2.1 optional) If you want to pre-populate the database with some survivors run

```
rails db:seed

```

3. To run the project:
```
rails s

```

4. To run the tests:
```
bundle exec rspec

```
# API endpoints

## SURVIVORS

- GET http://localhost:3000/survivors

  - List all non-infected survivors and their repository items.
  - Response:
    - 200 ok

- POST http://localhost:3000/survivors

  - Create a new survivor. Parameters must be something like:

```
{
  "survivor": {
    "name": "Joseph",
    "age": 25,
    "gender": "Male",
    "latitude": "25",
    "longitude": "940",
    "inventory": { 
      "water": 1,
      "food": 5,
      "medication": 0,
      "ammunition": 0
    }
  }
}

```
- Response:
  - 201 created, when survivor is created with success
    ```
    {
      "id": 17,
      "name": "Joseph",
      "age": 25,
      "gender": "Male",
      "latitude": "25",
      "longitude": "940",
      "infected": 0,
      "water": 1,
      "food": 5,
      "medication": 0,
      "ammunition": 0,
      "created_at": "2019-02-27T13:57:54.249Z",
      "updated_at": "2019-02-27T13:57:54.249Z"
    }
    
    ```
  - 400 bad_request when 'survivor' or 'inventory' key is missing
  - 422 unprocessable_entity when some of the parameters is missing or have wrong format
      
#### IMPORTANT: you must give in paramaters all types of resources (water, food, medication and ammunition), even when the amount is zero.

- GET http://localhost:3000/survivors/:id
  - Show information about the survivor who has the given id
  - Response:
    - 200 ok
    - 404 not found when id does not exist
    - 403 forbidden when survivor is infected
      ```
      "message": "can not show infected survivor"
      ```
- PUT/PATCH http://localhost:3000/survivors/:id
  - Update location about the survivor who has the given id
  
  ```
  {
   "location": {
	    "latitude": "10",
	    "longitude": "340"
   }
  }
  ```
  - Responses:
    - 204 no content when update has success

    - 403 forbidden when survivor is infected
    ```
    "message": "infected survivor can not update location"
    ```
   - 400 bad_request when 'location' key is missing
   - 422 unprocessable_entity when latitude or longitude is missing or have wrong format
     
## FLAG INFECTED

Since the action of flag some survivor infected is not an idempotent action, it was made with POST request.

- POST http://localhost:3000/infected
  - Flag some survivor as infected. Parameters must be like:
  ```
  {
	  "id": 17
  }
  ```
  - Responses:
    - 200 ok when flag is made with success
    - 204 when the is no id in parameters, or survivor with given id does not exist
    
## TRADE ITEMS
  - POST http://localhost:3000/trade
  
  Parameters must be something like:
  ```
  { "items":
	  [
	   {
      "id": 17,
      "food": 2
	   },
	   {
      "id": 18,	
      "medication": 2,
      "ammunition": 2
      }
    ]
  }  
  ```
 -Responses:
  - 200 ok when trade is made with success
  ```
  {
    "survivor_1": {
        "water": 1,
        "food": 3,
        "medication": 2,
        "ammunition": 2
    },
    "survivor_2": {
        "water": 1,
        "food": 3,
        "medication": 2,
        "ammunition": 0
    }
  }
  
  ```
  - 404 not_found when some of given id does not exist
  - 422 unprocessable_entity when items do not have same number of points
  ```
  {"message": "items do not have same number of points"}
  ```
  or at least one of the survivors does not have enough items to trade
  ```
  {"message": "at least one of the survivors does not have enough items to trade"}
  ```
  or given params are in wrong format
  
  - 400 bad_request when id key is missing
  - 403 forbidden when at least one of the survivors is infected
  ```
    {"message": "infected survivor can not trade items"}
  ```
 
 ## REPORTS
 
 ### Percentage of infected survivors:
 
 - GET http://localhost:3000/reports/infected_survivors
  - Responses: 
    - 200 ok
   ```
    {
      "infected_survivors": "33%"
    }
   ```
 ### Percentage of non-infected survivors:
  - GET http://localhost:3000/reports/non_infected_survivors
   - Responses: 
    - 200 ok
   ```
    {
      "non_infected_survivors": "67%"
    }

  ```
### Average amount of each kind of resource by survivor
 - GET http://localhost:3000/reports/average_resources
  - Responses: 
    - 200 ok
  ```
    {
      
      "water": 1.33,
      "food": 3,
      "medication": 3,
      "ammunition": 3
    }
  ```
### Points lost because of infected survivor.

- GET http://localhost:3000/reports/points_lost
- Responses: 
    - 200 ok
    
   
  ```
   {
      "points_lost": 19
   }
  ```

 
