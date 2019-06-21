// ***** @api {POST} api/auth/ Login user *****

/**
 * @api {POST} api/auth/ Login user
 * @apiVersion 0.1.0
 * @apiName LoginUser
 * @apiGroup User
 * @apiDescription Request headers are need:  
 * x-auth-token = token  
 * content/type = application/json
 * 
 * @apiSuccess {String} token JWT signed token containing user information.
 * @apiSuccess {Object} user  User Login
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
{
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjYTVkMzcyNTQ5NmE1NDk4Y2EyZWJjYyIsImVtYWlsIjoidGVzdDFAZ21haWwuY29tIiwiZmlyc3ROYW1lIjoiSm9obiIsImxhc3ROYW1lIjoiRG9lIiwicGhvbmVOdW1iZXIiOiIxMjMtNDU2LTc4OTAiLCJpYXQiOjE1NTQzNzc3NzUsImV4cCI6MTU1NDYzNjk3NX0.cm4k_1I7UPKlr9klDj1uYT4xZ2wFx_U8xqQJuXBabXI",
    "user": {
        "id": "5ca5d3725496a5498ca2ebcc",
        "email": "test1@gmail.com",
        "firstName": "John",
        "lastName": "Doe",
        "phoneNumber": "123-456-7890"
    }
}
 * 
 * @apiErrorExample {json} Error-Response:
 *     HTTP/1.1 400 Bad Request
{
    "errors": [
        {
            "message": "Email and/or password is incorrect."
        }
    ]
}
 */

// ***** @api {GET} api/auth/user Get get current user *****

/**
 * @api {GET} api/auth/user Get get current user
 * @apiVersion 0.1.0
 * @apiName GetUser
 * @apiGroup User
 * @apiDescription Request headers are need:  
 * x-auth-token = token  
 * content/type = application/json
 * @apiSuccess {Object} user  User logged in
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
    "firstName": "John",
    "lastName": "Doe",
    "phoneNumber": "123-456-7890",
    "bio": "Welcome, to Rommie!",
    "registeredDate": "2019-04-04T09:50:42.104Z",
    "__v": 0
}
 * 
 * @apiErrorExample {json} Error-Response:
 *     HTTP/1.1 400 Bad Request
{
    "errors": [
        {
            "message": "Token is unauthorized"
        }
    ]
}
 */

// ***** @api {POST} api/auth/user Login user *****

/**
 * @api {POST} api/auth/user Create user account
 * @apiVersion 0.1.0
 * @apiName CreateUser
 * @apiGroup User
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
"email":"test1@gmail.com",
"password":"password",
"firstName":"John",
"lastName":"Doe",
"phoneNumber":"123-456-7890",
"bio":"Welcome, to rommie!",
"roles":["buyer"]
}
 *
 * @apiSuccess {String} token JWT signed token containing user information.
 * @apiSuccess {Object} user  New user created
 * 
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
{
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlcyI6WyJidXllciJdLCJyb29tbWF0ZXMiOltdLCJmYXZMaXN0aW5ncyI6W10sIl9pZCI6IjVjYTVkMzcyNTQ5NmE1NDk4Y2EyZWJjYyIsImVtYWlsIjoidGVzdDFAZ21haWwuY29tIiwiZmlyc3ROYW1lIjoiSm9obiIsImxhc3ROYW1lIjoiRG9lIiwicGhvbmVOdW1iZXIiOiIxMjMtNDU2LTc4OTAiLCJiaW8iOiJXZWxjb21lLCB0byByb21taWUhIiwicmVnaXN0ZXJlZERhdGUiOiIyMDE5LTA0LTA0VDA5OjUwOjQyLjEwNFoiLCJfX3YiOjAsImlhdCI6MTU1NDM3MTQ0MiwiZXhwIjoxNTU0NDU3ODQyfQ.IMgb-sYTN63zI5I-ZxI3cGnzam8qFEFeMtItZGkgC0M",
    "user": {
        "roles": [
            "buyer"
        ],
        "roommates": [],
        "favListings": [],
        "_id": "5ca5d3725496a5498ca2ebcc",
        "email": "test1@gmail.com",
        "firstName": "John",
        "lastName": "Doe",
        "phoneNumber": "123-456-7890",
        "bio": "Welcome, to rommie!",
        "registeredDate": "2019-04-04T09:50:42.104Z",
        "__v": 0
    }
}
 * 
 * @apiErrorExample {json} Error-Response:
 *     HTTP/1.1 400 Not Found
{
    "errors": [
        {
            "message": "Path `lastName` is required.",
            "validationType": "required",
            "fieldName": "lastName"
        },
        {
            "message": "Path `firstName` is required.",
            "validationType": "required",
            "fieldName": "firstName"
        },
        {
            "message": "Path `phoneNumber` is required.",
            "validationType": "required",
            "fieldName": "phoneNumber"
        },
        {
            "message": "Path `password` is required.",
            "validationType": "required",
            "fieldName": "password"
        },
        {
            "message": "Path `email` is required.",
            "validationType": "required",
            "fieldName": "email"
        }
    ]
}
 */
