// ***** @api {GET} api/admin/users Get all users *****

/**
 * @api {GET} api/admin/users Get all users
 * @apiVersion 0.1.0
 * @apiName GetUsers
 * @apiGroup Admin
 * @apiDescription Request headers are need:  
 * x-auth-token = token  
 * content/type = application/json
 * 
 * 
 * @apiSuccess {Array} users  Array of users
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
[
    {
        "roles": [
            "buyer"
        ],
        "roommates": [],
        "favListings": [],
        "_id": "5cbe2d777d99140cfcd3a902",
        "email": "test1@gmail.com",
        "password": "$2a$10$M.3g3CkftNnTgmgg1Zqe7uT38Diqii2zRESvaXgbOhbqGpuyemose",
        "firstName": "John",
        "lastName": "Doe",
        "phoneNumber": "123-456-7890",
        "bio": "Welcome, to rommie!",
        "registeredDate": "2019-04-22T21:09:11.099Z",
        "__v": 0
    },
    {
        "roles": [
            "buyer"
        ],
        "roommates": [],
        "favListings": [],
        "_id": "5cbe2d7a7d99140cfcd3a903",
        "email": "test2@gmail.com",
        "password": "$2a$10$6yYIfWS.MobQPeA7wrKdEOAWgr0PKLBtkEt3DXFPGGtg36564dS/a",
        "firstName": "John",
        "lastName": "Doe",
        "phoneNumber": "123-456-7890",
        "bio": "Welcome, to rommie!",
        "registeredDate": "2019-04-22T21:09:14.415Z",
        "__v": 0
    }
]
 */

// ***** @api {DELETE} api/admin/users Delete all users *****

/**
 * @api {DELETE} api/admin/users Delete all users
 * @apiVersion 0.1.0
 * @apiName DeleteUsers
 * @apiGroup Admin
 * @apiDescription Request headers are need:  
 * x-auth-token = token  
 * content/type = application/json
 * @apiSuccess {Object} message "Users deleted"
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
{
    "message": "Users deleted..."
}
 */

// ***** @api {DELETE} api/admin/listings Delete all listings *****

/**
 * @api {DELETE} api/admin/listings Delete all listings
 * @apiVersion 0.1.0
 * @apiName DeleteListings
 * @apiGroup Admin
 * @apiDescription Request headers are need:  
 * x-auth-token = token  
 * content/type = application/json
 * @apiSuccess {Object} message "Listings deleted"
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
{
    "message": "Listings deleted..."
}
 */
