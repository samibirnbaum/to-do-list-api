# To-Do-List-API

small description

![Snapshot](app/assets/images/snapshot.png)

[Case Study](https://samibirnbaum.com/portfolio/samipedia.html)

## Usage

1. Fork and clone the repo: `git clone https://github.com/samibirnbaum/samipedia.git`
2. You must have Ruby installed (built using version 2.4.1)
3. Run `$ bundle install` to download/install the needed dependencies
4. Start the local server: `$ rails s` and utilise `http://localhost:3000`
5. Make requests to the API using the guide below.

<hr>

## Authenticate
**Apart from creating a User you will need to authenticate with the Api every time you make a request.
Use `Basic Auth`. 
You can do this using a tool like [Postman](https://www.getpostman.com/)
or [Curl](https://curl.haxx.se/) `curl -u username:password http://localhost:3000/api/users/`**

<hr>

## Users
### Create a user
Method: `POST`

Path: http://localhost:3000/api/users

Body:
```json
{"user":
	{
	"password":"password",
	"username":"Tom Bombadil",
	"email":"gregsorio_hermiston@yahoo.com"
	}
}
```

### Get all users
Method: `GET`

Path: http://localhost:3000/api/users

Body: N/A

### Delete a user
Method: `DELETE`

Path: http://localhost:3000/api/users/:user_id

`:user_id` must be replaced with an integer of your own user id. This can be found from the create user response or by calling get all users.

Body: N/A


<hr>

## Lists
### Create a list
Method: `POST`

Path: http://localhost:3000/api/users/:user_id/lists

`:user_id` must be replaced with an integer of your own user id. This can be found from the create user response or by calling get all users.

Body:
```json
{"list":
	{
	"name":"TO DO",
	"private":"false"
	}
}
```

### Delete a list
Method: `DELETE`

Path: http://localhost:3000/api/users/:user_id/lists/:list_id

`:user_id` must be replaced with an integer of your own user id. This can be found from the create user response or by calling get all users.

`:list_id` must be replaced with an integer of your own list id. This can be found from the create list response.

Body: N/A
<hr>

## Items
### Create an item
Method: `POST`

Path: http://localhost:3000/api/lists/:list_id/items

`:list_id` must be replaced with an integer of your own list id. This was returned to you when you created your list.

Body:
```json
{"item":
	{
	"name":"Take the bins out",
	"private":"false"
	}
}
```