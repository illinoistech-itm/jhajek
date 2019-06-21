// ***** @api {GET} api/user/:id Update user *****

/**
 * @api {GET} api/user/:id Update user
 * @apiVersion 0.1.0
 * @apiName UpdateUSer
 * @apiGroup User
 * @apiDescription Request headers are need:  
 * x-auth-token = token  
 * content/type = application/json
 * 
 * @apiParam {String} email       Email of the User.
 * @apiParam {String} password    Password of the User.
 * @apiParam {String} fistName    First name of the User.
 * @apiParam {String} lastName    lastName of the User.
 * @apiParam {String} phoneNumber Phone number of the User.
 * @apiParam {String} bio         Bio of the User.
 * @apiParam {Array} roles        Lastname of the User.
 * @apiParamExample {json} Request-Example:
{
"roles":["buyer, seller"]
}
 *
 * @apiSuccess {String} token JWT signed token containing user information.
 * @apiSuccess {Object} user  User updated
 * 
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
{
    "roles": [
        "buyer"
    ],
    "roommates": [],
    "favListings": [],
    "_id": "5ca5d3725496a5498ca2ebcc",
    "email": "test1@gmail.com",
    "password": "$2a$10$a90Y0QBOAhJmV3L4YC7NyO0z3ZDUWrFymMSFpWt45UWNOmGFIngVi",
    "firstName": "John",
    "lastName": "Doe",
    "phoneNumber": "123-456-7890",
    "bio": "Welcome, to rommie!",
    "registeredDate": "2019-04-04T09:50:42.104Z",
    "__v": 0
}
 * 
 * @apiErrorExample {json} Error-Response:
 *     HTTP/1.1 401 Unauthorized
{
    "errors": [
        {
            "message": "Token is unauthorized"
        }
    ]
}
 */

// ***** @api {DELETE} api/user/:id Delete user *****

/**
 * @api {DELETE} api/user/:id Delete user
 * @apiVersion 0.1.0
 * @apiName DeleteUSer
 * @apiGroup User
 * @apiDescription Request headers are need:  
 * x-auth-token = token  
 *
 * @apiSuccess {Object} user  User Deleted
 * 
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
{
    "roles": [
        "buyer"
    ],
    "roommates": [],
    "favListings": [],
    "_id": "5ca5d3725496a5498ca2ebcc",
    "email": "test1@gmail.com",
    "password": "$2a$10$a90Y0QBOAhJmV3L4YC7NyO0z3ZDUWrFymMSFpWt45UWNOmGFIngVi",
    "firstName": "John",
    "lastName": "Doe",
    "phoneNumber": "123-456-7890",
    "bio": "Welcome, to rommie!",
    "registeredDate": "2019-04-04T09:50:42.104Z",
    "__v": 0
}
 * 
 * @apiErrorExample {json} Error-Response:
 *     HTTP/1.1 401 Unauthorized
{
    "errors": [
        {
            "message": "Token is unauthorized"
        }
    ]
}
 */

// ***** @api {GET} api/user/:id Get a user *****

/**
 * @api {GET} api/user/:id Get a user
 * @apiVersion 0.1.0
 * @apiName GetUser
 * @apiGroup User
 * @apiDescription Request headers are need:  
 * x-auth-token = token  
 *
 * @apiSuccess {Object} user  Object of user.
 * 
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
{
    "user": {
        "roles": [
            "buyer, seller, Double seller"
        ],
        "roommates": [],
        "favListings": [],
        "_id": "5cbeb669ee9d8a4adc42d088",
        "email": "test3@gmail.com",
        "firstName": "John",
        "lastName": "Doe",
        "phoneNumber": "123-456-7890",
        "bio": "Welcome, to rommie!",
        "registeredDate": "2019-04-23T06:53:29.364Z",
        "__v": 0
    }
}
 * 
 * @apiErrorExample {json} Error-Response:
 *     HTTP/1.1 401 Unauthorized
{
    "errors": [
        {
            "message": "User don't exist"
        }
    ]
}
 */

// ***** @api {GET} api/user/listings Get a users listings *****

/**
 * @api {GET} api/user/listings Get a users listings
 * @apiVersion 0.1.0
 * @apiName GetUserListings
 * @apiGroup Listings
 * @apiDescription Request headers are need:  
 * x-auth-token = token  
 *
 * @apiSuccess {Array} listings  Array of  user listings.
 * 
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
[
    {
        "address": {
            "street": "1111 S. Main St.",
            "city": "Chicago",
            "state": "Illinois",
            "zipCode": 60616
        },
        "amenities": {
            "parkingType": [
                "street",
                "garage"
            ],
            "petsAllowed": [
                "Small dogs",
                "Small Cats"
            ],
            "wifi": true,
            "heating": true,
            "cooling": true,
            "washer": true,
            "indoorFireplace": true
        },
        "photos": [
            "src/photos/url",
            "src/photos/url2"
        ],
        "_id": "5ca576a0efd880249862eafb",
        "seller": "5ca560dbbeb0553e94954bc7",
        "price": 499,
        "squareFootage": 1239,
        "bedrooms": 3,
        "bathrooms": 2,
        "listingType": "condo",
        "name": "Listing 1",
        "dateListed": "2019-04-04T03:14:40.572Z",
        "__v": 0
    }
  ]
 * 
 * @apiErrorExample {json} Error-Response:
 *     HTTP/1.1 401 Unauthorized
{
    "errors": [
        {
            "message": "User don't exist"
        }
    ]
}
 */
